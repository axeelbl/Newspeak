package newspeak

import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_WRITER')
class WriterController {

    def springSecurityService

    def index() {
        redirect(action: "myArticles")
    }

    def myArticles() {
        def currentUser = springSecurityService.currentUser
        def articles = Article.findAllByAuthor(currentUser, [sort: "dateCreated", order: "desc"])
        [articles: articles]
    }

    def createArticle() {
        [article: new Article()]
    }

    def saveArticle() {
        def currentUser = springSecurityService.currentUser

        def article = new Article(
                title: params.title,
                description: params.description,
                content: params.content,
                imageUrl: params.imageUrl,
                author: currentUser,
                published: false
        )

        if (article.save(flush: true)) {
            flash.message = "Artículo creado correctamente"
            redirect(action: "myArticles")
        } else {
            flash.error = "Error al crear el artículo"
            render(view: "createArticle", model: [article: article])
        }
    }

    def editArticle() {
        def currentUser = springSecurityService.currentUser
        def article = Article.get(params.id)

        if (!article) {
            flash.error = "Artículo no encontrado"
            redirect(action: "myArticles")
            return
        }

        if (article.author.id != currentUser.id) {
            flash.error = "No tienes permiso para editar este artículo"
            redirect(action: "myArticles")
            return
        }

        [article: article]
    }

    def updateArticle() {
        def currentUser = springSecurityService.currentUser
        def article = Article.get(params.id)

        if (!article) {
            flash.error = "Artículo no encontrado"
            redirect(action: "myArticles")
            return
        }

        if (article.author.id != currentUser.id) {
            flash.error = "No tienes permiso para editar este artículo"
            redirect(action: "myArticles")
            return
        }

        article.title = params.title
        article.description = params.description
        article.content = params.content
        article.imageUrl = params.imageUrl

        if (article.save(flush: true)) {
            flash.message = "Artículo actualizado correctamente"
            redirect(action: "myArticles")
        } else {
            flash.error = "Error al actualizar el artículo"
            render(view: "editArticle", model: [article: article])
        }
    }

    def deleteArticle() {
        def currentUser = springSecurityService.currentUser
        def article = Article.get(params.id)

        if (!article) {
            flash.error = "Artículo no encontrado"
            redirect(action: "myArticles")
            return
        }

        if (article.author.id != currentUser.id) {
            flash.error = "No tienes permiso para eliminar este artículo"
            redirect(action: "myArticles")
            return
        }

        article.delete(flush: true)
        flash.message = "Artículo eliminado correctamente"
        redirect(action: "myArticles")
    }

    // Nuevo método para publicar/despublicar artículos
    def togglePublishStatus() {
        def currentUser = springSecurityService.currentUser
        def article = Article.get(params.id)

        if (!article) {
            flash.error = "Artículo no encontrado"
            redirect(action: "myArticles")
            return
        }

        if (article.author.id != currentUser.id) {
            flash.error = "No tienes permiso para modificar este artículo"
            redirect(action: "myArticles")
            return
        }

        article.published = !article.published

        if (article.save(flush: true)) {
            flash.message = article.published ?
                    "Artículo '${article.title}' publicado correctamente" :
                    "Artículo '${article.title}' despublicado correctamente"
        } else {
            flash.error = "Error al cambiar el estado de publicación del artículo"
        }

        redirect(action: "myArticles")
    }
}