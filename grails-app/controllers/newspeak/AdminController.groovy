package newspeak

import grails.plugin.springsecurity.annotation.Secured
import org.bson.types.ObjectId

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

    // Métodos para gestionar los escritores - CORREGIDO
    def manageWriters() {
        def writerRole = Role.findByAuthority('ROLE_WRITER')

        // Obtenemos los usuarios con rol de escritor
        def writerUserRoles = UserRole.findAllByRole(writerRole)
        def writers = []
        writerUserRoles.each { userRole ->
            def user = User.get(userRole.user.id)
            if (user) {
                writers.add(user)
            }
        }

        // Obtenemos todos los usuarios
        def allUsers = User.list()

        // Filtramos los usuarios que no tienen rol de escritor
        def nonWriters = allUsers.findAll { user ->
            !UserRole.findByUserAndRole(user, writerRole)
        }

        [writers: writers, nonWriters: nonWriters]
    }

    def addWriterRole() {
        def userId = params.userId
        def user

        // Manejo correcto del ID para MongoDB
        try {
            if (userId instanceof String) {
                user = User.get(new ObjectId(userId))
            } else {
                user = User.get(userId)
            }
        } catch (Exception e) {
            flash.error = "ID de usuario inválido: ${e.message}"
            redirect(action: "manageWriters")
            return
        }

        def writerRole = Role.findByAuthority('ROLE_WRITER')

        if (user && writerRole) {
            def existingRole = UserRole.findByUserAndRole(user, writerRole)
            if (!existingRole) {
                // Creamos la nueva relación usuario-rol
                try {
                    UserRole.create(user, writerRole, true)
                    flash.message = "Rol de escritor asignado a ${user.username} correctamente"
                } catch (Exception e) {
                    flash.error = "Error al asignar rol: ${e.message}"
                }
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
        def user

        // Manejo correcto del ID para MongoDB
        try {
            if (userId instanceof String) {
                user = User.get(new ObjectId(userId))
            } else {
                user = User.get(userId)
            }
        } catch (Exception e) {
            flash.error = "ID de usuario inválido: ${e.message}"
            redirect(action: "manageWriters")
            return
        }

        def writerRole = Role.findByAuthority('ROLE_WRITER')

        if (user && writerRole) {
            def userRole = UserRole.findByUserAndRole(user, writerRole)
            if (userRole) {
                try {
                    userRole.delete(flush: true)
                    flash.message = "Rol de escritor removido de ${user.username} correctamente"
                } catch (Exception e) {
                    flash.error = "Error al eliminar rol: ${e.message}"
                }
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