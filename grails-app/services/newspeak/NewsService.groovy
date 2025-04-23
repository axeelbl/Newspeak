package newspeak

import grails.core.GrailsApplication
import groovy.json.JsonSlurper

class NewsService {

    // Inyección de GrailsApplication
    GrailsApplication grailsApplication

    List<Map> getTopHeadlines(String searchTerm = "Actualidad") {
        try {
            // Usamos directamente la API key sin configuración
            def lenguaje = "es"
            def tema = searchTerm ?: "Actualidad"
            // Obtener la API key de la configuración
            def apiKey = grailsApplication.config.newsapi.key
            def url = "https://newsapi.org/v2/everything?q=${tema}&language=${lenguaje}&apiKey=${apiKey}"

            def connection = new URL(url).openConnection()
            connection.requestMethod = 'GET'

            def responseText = connection.inputStream.text
            def json = new JsonSlurper().parseText(responseText)

            // Verificamos si hay artículos
            if (json.status == 'ok' && json.articles) {
                return json.articles.collect { article ->
                    [
                            title: article.title,
                            description: article.description,
                            content: article.content,
                            url: article.url,
                            urlToImage: article.urlToImage
                    ]
                }
            }

            // Si llegamos aquí, algo falló
            return []

        } catch (Exception e) {
            println "Error en NewsService: ${e.message}"
            return []
        }
    }
}