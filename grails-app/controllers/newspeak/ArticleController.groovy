package newspeak

class ArticleController {

    def view() {
        def article = Article.get(params.id)

        if (!article) {
            flash.error = "Artículo no encontrado"
            redirect(controller: "home", action: "homeScreen")
            return
        }

        if (!article.published) {
            flash.error = "Este artículo no está disponible"
            redirect(controller: "home", action: "homeScreen")
            return
        }

        [article: article]
    }
}

