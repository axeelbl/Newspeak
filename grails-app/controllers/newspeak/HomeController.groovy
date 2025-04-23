package newspeak

class HomeController {

    def newsService // Inyección del servicio de noticias

    def homeScreen() {
        try {
            // Obtener el término de búsqueda de los parámetros de la solicitud
            def searchTerm = params.searchTerm

            // Pasar el término de búsqueda al servicio si existe
            def articles = searchTerm ? newsService.getTopHeadlines(searchTerm) : newsService.getTopHeadlines()

            if (articles && !articles.isEmpty()) {
                return [articles: articles]
            } else {
                return [articles: [], error: "No se pudieron obtener las noticias"]
            }
        } catch (Exception e) {
            return [articles: [], error: "Error al obtener noticias: ${e.message}"]
        }
    }

    // Esta función es necesaria para redirigir 'homeScreen' a 'Index', si no no funciona.
    def index() {
        redirect(action: "homeScreen")
    }
}