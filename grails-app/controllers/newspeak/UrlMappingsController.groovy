package newspeak

class UrlMappings {
    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {

            }
        }

        "/"(view: "/login/auth")
        "/home"(controller: "home", action: "homeScreen")
        "/admin"(controller: "admin", action: "manageNews")

        "500"(controller: "error", action: "error")
        "404"(view: '/notFound')

    }
}