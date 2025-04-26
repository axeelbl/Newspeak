package newspeak

import grails.core.GrailsApplication
import groovy.json.JsonSlurper

class NewsService {

    GrailsApplication grailsApplication

    List<Map> getTopHeadlines(String searchTerm = "Actualidad") {
        try {
            // Obtener noticias de la API
            def lenguaje = "es"
            def tema = searchTerm ?: "Actualidad"
            def apiKey = grailsApplication.config.newsapi.key
            def url = "https://newsapi.org/v2/everything?q=${tema}&language=${lenguaje}&apiKey=${apiKey}"

            def connection = new URL(url).openConnection()
            connection.requestMethod = 'GET'

            def responseText = connection.inputStream.text
            def json = new JsonSlurper().parseText(responseText)

            def articles = []

            // Procesar artículos de la API
            if (json.status == 'ok' && json.articles) {
                articles = json.articles.collect { article ->
                    [
                            title: article.title,
                            description: article.description,
                            content: article.content,
                            url: article.url,
                            urlToImage: article.urlToImage,
                            source: "api"
                    ]
                }
            }

            // Obtener artículos propios publicados
            def ownArticles = Article.findAllByPublished(true).collect { article ->
                [
                        title: article.title,
                        description: article.description,
                        content: article.content,
                        url: "/article/view/${article.id}",
                        urlToImage: article.imageUrl ?: "https://via.placeholder.com/300x180?text=Newspeak",
                        author: article.author.username,
                        dateCreated: article.dateCreated,
                        id: article.id,
                        source: "own"
                ]
            }

            // Combinar ambas fuentes de noticias
            articles.addAll(ownArticles)

            // Filtrar las noticias bloqueadas
            def blockedUrls = BlockedNews.list().collect { it.url }
            return articles.findAll { !blockedUrls.contains(it.url) }

        } catch (Exception e) {
            println "Error en NewsService: ${e.message}"
            return []
        }
    }

    // Método para bloquear una noticia
    def blockNews(String url, String reason, String username) {
        if (!BlockedNews.findByUrl(url)) {
            new BlockedNews(
                    url: url,
                    reason: reason,
                    dateBlocked: new Date(),
                    blockedBy: username
            ).save(flush: true)
            return true
        }
        return false
    }

    // Método para desbloquear una noticia
    def unblockNews(String url) {
        def blockedNews = BlockedNews.findByUrl(url)
        if (blockedNews) {
            blockedNews.delete(flush: true)
            return true
        }
        return false
    }

    // Obtener todas las noticias bloqueadas
    def getBlockedNews() {
        BlockedNews.list()
    }
}