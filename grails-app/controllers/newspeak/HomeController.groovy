package newspeak

class HomeController {

    def newsService
    def springSecurityService

    def homeScreen() {
        try {
            def searchTerm = params.searchTerm
            def articles = searchTerm ? newsService.getTopHeadlines(searchTerm) : newsService.getTopHeadlines()

            // Determinar roles del usuario
            def isAdmin = false
            def isWriter = false

            if (springSecurityService.isLoggedIn()) {
                def user = springSecurityService.currentUser
                def authorities = user.authorities.collect { it.authority }
                isAdmin = authorities.contains('ROLE_ADMIN')
                isWriter = authorities.contains('ROLE_WRITER')
            }

            if (articles && !articles.isEmpty()) {
                return [articles: articles, isAdmin: isAdmin, isWriter: isWriter]
            } else {
                return [articles: [], error: "No se pudieron obtener las noticias", isAdmin: isAdmin, isWriter: isWriter]
            }
        } catch (Exception e) {
            return [articles: [], error: "Error al obtener noticias: ${e.message}", isAdmin: false, isWriter: false]
        }
    }

    def index() {
        redirect(action: "homeScreen")
    }
}