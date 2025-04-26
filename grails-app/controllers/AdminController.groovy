package newspeak

import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_ADMIN')
class AdminController {

    def newsService
    def springSecurityService

    def index() {
        redirect(action: "manageNews")
    }

    def manageNews() {
        [articles: newsService.getTopHeadlines(), blockedNews: newsService.getBlockedNews()]
    }

    def blockNews() {
        def currentUser = springSecurityService.currentUser
        if (newsService.blockNews(params.url, params.reason, currentUser.username)) {
            flash.message = "Noticia bloqueada correctamente"
        } else {
            flash.error = "La noticia ya está bloqueada"
        }
        redirect(action: "manageNews")
    }

    def unblockNews() {
        if (newsService.unblockNews(params.url)) {
            flash.message = "Noticia desbloqueada correctamente"
        } else {
            flash.error = "No se encontró la noticia bloqueada"
        }
        redirect(action: "manageNews")
    }
}