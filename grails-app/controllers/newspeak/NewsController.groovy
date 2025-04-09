package newspeak

class NewsController {

    def guardarNoticia() {
        def noticia = new News(
                titulo: "Ejemplo desde controlador",
                contenido: "Este es el contenido de prueba",
                fuente: "NewsAPI"
        )

        if (noticia.save(flush: true)) {
            render "Noticia guardada correctamente"
        } else {
            render "Error al guardar la noticia"
        }
    }
}
