package newspeak

class HomeController {

    def newsService
    def springSecurityService

    def homeScreen() {
        try {
            def searchTerm = params.searchTerm
            def articles = searchTerm ? newsService.getTopHeadlines(searchTerm) : newsService.getTopHeadlines()

            // Determinar si el usuario tiene rol de administrador
            def isAdmin = false
            if (springSecurityService.isLoggedIn()) {
                def user = springSecurityService.currentUser
                isAdmin = user.authorities.any { it.authority == 'ROLE_ADMIN' }
            }

            if (articles && !articles.isEmpty()) {
                return [articles: articles, isAdmin: isAdmin]
            } else {
                return [articles: [], error: "No se pudieron obtener las noticias", isAdmin: isAdmin]
            }
        } catch (Exception e) {
            return [articles: [], error: "Error al obtener noticias: ${e.message}", isAdmin: false]
        }
    }

    def index() {
        redirect(action: "homeScreen")
    }
}