package newspeak

import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_ADMIN')
class AdminController {

    def springSecurityService

    def index() {
        redirect(action: "manageNews")
    }

    def manageNews() {
        def blockedNews = BlockedNews.list([sort: "dateBlocked", order: "desc"])
        [blockedNews: blockedNews]
    }

    def blockNews() {
        def url = params.url
        def reason = params.reason ?: "Contenido inapropiado"
        def username = springSecurityService.currentUser.username

        def newsService = new NewsService()
        if (newsService.blockNews(url, reason, username)) {
            flash.message = "Noticia bloqueada correctamente"
        } else {
            flash.error = "La noticia ya estaba bloqueada"
        }
        redirect(action: "manageNews")
    }

    def unblockNews() {
        def url = params.url
        def newsService = new NewsService()
        if (newsService.unblockNews(url)) {
            flash.message = "Noticia desbloqueada correctamente"
        } else {
            flash.error = "Error al desbloquear la noticia"
        }
        redirect(action: "manageNews")
    }

    // Métodos para gestionar los escritores
    def manageWriters() {
        def writerRole = Role.findByAuthority('ROLE_WRITER')
        def writers = UserRole.findAllByRole(writerRole).collect { it.user }

        def allUsers = User.list()
        def nonWriters = allUsers.findAll { user ->
            !UserRole.exists(user.id, writerRole.id)
        }

        [writers: writers, nonWriters: nonWriters]
    }

    def addWriterRole() {
        def userId = params.userId
        def user = User.get(userId)
        def writerRole = Role.findByAuthority('ROLE_WRITER')

        if (user && writerRole) {
            if (!UserRole.exists(user.id, writerRole.id)) {
                UserRole.create(user, writerRole, true)
                flash.message = "Rol de escritor asignado a ${user.username} correctamente"
            } else {
                flash.error = "El usuario ya tiene el rol de escritor"
            }
        } else {
            flash.error = "Usuario o rol no encontrado"
        }

        redirect(action: "manageWriters")
    }

    def removeWriterRole() {
        def userId = params.userId
        def user = User.get(userId)
        def writerRole = Role.findByAuthority('ROLE_WRITER')

        if (user && writerRole) {
            def userRole = UserRole.findByUserAndRole(user, writerRole)
            if (userRole) {
                userRole.delete(flush: true)
                flash.message = "Rol de escritor removido de ${user.username} correctamente"
            } else {
                flash.error = "El usuario no tiene el rol de escritor"
            }
        } else {
            flash.error = "Usuario o rol no encontrado"
        }

        redirect(action: "manageWriters")
    }

    // Métodos para gestionar los artículos
    def manageArticles() {
        def articles = Article.list([sort: "dateCreated", order: "desc"])
        [articles: articles]
    }

    def toggleArticleStatus() {
        def article = Article.get(params.id)

        if (article) {
            article.published = !article.published
            article.save(flush: true)
            flash.message = article.published ?
                    "Artículo '${article.title}' publicado correctamente" :
                    "Artículo '${article.title}' despublicado correctamente"
        } else {
            flash.error = "Artículo no encontrado"
        }

        redirect(action: "manageArticles")
    }

    def deleteArticle() {
        def article = Article.get(params.id)

        if (article) {
            def title = article.title
            article.delete(flush: true)
            flash.message = "Artículo '${title}' eliminado correctamente"
        } else {
            flash.error = "Artículo no encontrado"
        }

        redirect(action: "manageArticles")
    }
}