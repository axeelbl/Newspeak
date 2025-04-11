package newspeak

class HomeController {

    def newsService // Inyección del servicio de noticias

    def homeScreen() {
        try {
            def articles = newsService.getTopHeadlines()

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