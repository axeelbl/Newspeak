package newspeak

class News  {
    String titulo
    String descripcion
    String url
    String fuente
    Date fecha
    String categoria // como "technology", "business", etc.

    static constraints = {
        titulo nullable: false
        descripcion nullable: true
        url nullable: false
        fuente nullable: true
        categoria nullable: true
    }
}
