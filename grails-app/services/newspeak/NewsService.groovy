package newspeak

import grails.core.GrailsApplication
import groovy.json.JsonSlurper

class NewsService {

    GrailsApplication grailsApplication

    List<Map> getTopHeadlines(String searchTerm = "Actualidad") {
        try {
            def lenguaje = "es"
            def tema = searchTerm ?: "Actualidad"
            def apiKey = grailsApplication.config.newsapi.key
            def url = "https://newsapi.org/v2/everything?q=${tema}&language=${lenguaje}&apiKey=${apiKey}"

            def connection = new URL(url).openConnection()
            connection.requestMethod = 'GET'

            def responseText = connection.inputStream.text
            def json = new JsonSlurper().parseText(responseText)

            // Verificamos si hay artículos
            if (json.status == 'ok' && json.articles) {
                def articles = json.articles.collect { article ->
                    [
                            title: article.title,
                            description: article.description,
                            content: article.content,
                            url: article.url,
                            urlToImage: article.urlToImage
                    ]
                }

                // Filtrar las noticias bloqueadas
                def blockedUrls = BlockedNews.list().collect { it.url }
                return articles.findAll { !blockedUrls.contains(it.url) }
            }

            return []

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