package newspeak

class LoginController {
    def springSecurityService

    def auth() {
        if (springSecurityService.isLoggedIn()) {
            redirect(controller: 'home', action: 'homeScreen')
            return
        }
        // No es necesario el render explícito, Grails buscará automáticamente
        // la vista auth.gsp en el directorio login
    }
}