package newspeak

class ErrorController {

    def error() {
        render view: '/error' // Redirige a la vista error.gsp
    }
}