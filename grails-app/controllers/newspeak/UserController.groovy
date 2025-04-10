package newspeak

import org.springframework.security.crypto.password.PasswordEncoder

class UserController {
    PasswordEncoder passwordEncoder
    def springSecurityService

    // Acción para registro
    def register() {
        if (springSecurityService.isLoggedIn()) {
            redirect(controller: 'home', action: 'index')
            return
        }
        render(view: 'register', model: [user: new User()])
    }

    // Acción para guardar un nuevo usuario
    def save() {
        if (params.password != params.confirmPassword) {
            flash.message = "Las contraseñas no coinciden"
            flash.error = true
            render(view: "register", model: [user: new User(username: params.username)])
            return
        }

        def user = new User(
                username: params.username,
                password: passwordEncoder.encode(params.password),
                enabled: true
        )

        if (user.save(flush: true)) {
            // Asignar rol USER
            def role = Role.findByAuthority('ROLE_USER')
            if (!role) {
                role = new Role(authority: 'ROLE_USER').save(flush: true)
            }
            UserRole.create(user, role, true)
            flash.message = "Usuario creado correctamente. Ahora puede iniciar sesión."
            redirect(controller: "login", action: "auth")
        } else {
            flash.message = "Error al crear el usuario. Por favor, inténtelo de nuevo."
            flash.error = true
            render(view: "register", model: [user: user])
        }
    }
}