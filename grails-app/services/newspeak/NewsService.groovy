package newspeak

import grails.core.GrailsApplication
import groovy.json.JsonSlurper

import java.net.URLEncoder
import java.nio.charset.StandardCharsets

class NewsService {

    GrailsApplication grailsApplication

    List<Map> getTopHeadlines(String searchTerm = 'Actualidad') {
        def articles = fetchApiArticles(searchTerm)
        articles.addAll(Article.findAllByPublished(true).collect { article ->
            [
                    title: article.title,
                    description: article.description,
                    content: article.content,
                    url: "/article/view/${article.id}",
                    urlToImage: article.imageUrl ?: 'https://via.placeholder.com/300x180?text=Newspeak',
                    author: article.author.username,
                    dateCreated: article.dateCreated,
                    id: article.id,
                    source: 'own'
            ]
        })

        def blockedUrls = BlockedNews.list().collect { it.url } as Set
        articles.findAll { !blockedUrls.contains(it.url) }
    }

    protected List<Map> fetchApiArticles(String searchTerm) {
        def apiKey = grailsApplication.config.newsapi.key?.toString()?.trim()
        if (!apiKey) {
            log.info('NEWSAPI_KEY is not configured; returning only local articles')
            return []
        }

        try {
            def topic = URLEncoder.encode((searchTerm ?: 'Actualidad').take(100), StandardCharsets.UTF_8)
            def connection = new URL("https://newsapi.org/v2/everything?q=${topic}&language=es").openConnection()
            connection.requestMethod = 'GET'
            connection.connectTimeout = 5000
            connection.readTimeout = 10000
            connection.setRequestProperty('X-Api-Key', apiKey)

            def json = new JsonSlurper().parse(connection.inputStream, 'UTF-8')
            if (json.status != 'ok' || !json.articles) {
                return []
            }

            json.articles.collect { article ->
                [
                        title: article.title,
                        description: article.description,
                        content: article.content,
                        url: safeHttpUrl(article.url),
                        urlToImage: safeHttpUrl(article.urlToImage),
                        source: 'api'
                ]
            }.findAll { it.url }
        } catch (Exception ignored) {
            log.warn('NewsAPI request failed; returning only local articles')
            []
        }
    }

    private static String safeHttpUrl(def value) {
        if (!value) {
            return null
        }
        try {
            def uri = new URI(value.toString())
            uri.scheme?.toLowerCase() in ['http', 'https'] ? uri.toString() : null
        } catch (Exception ignored) {
            null
        }
    }

    boolean blockNews(String url, String reason, String username) {
        if (!BlockedNews.findByUrl(url)) {
            def blockedNews = new BlockedNews(
                    url: url,
                    reason: reason,
                    dateBlocked: new Date(),
                    blockedBy: username
            )
            return blockedNews.save(flush: true) != null
        }
        false
    }

    boolean unblockNews(String url) {
        def blockedNews = BlockedNews.findByUrl(url)
        if (blockedNews) {
            blockedNews.delete(flush: true)
            return true
        }
        false
    }

    List<BlockedNews> getBlockedNews() {
        BlockedNews.list()
    }
}
