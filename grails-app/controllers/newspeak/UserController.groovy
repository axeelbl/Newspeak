package newspeak

import org.springframework.security.crypto.password.PasswordEncoder

class UserController {
    static allowedMethods = [save: 'POST']

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
        def rawPassword = params.password?.toString()
        if (!rawPassword || rawPassword.length() < 12) {
            flash.message = "La contraseña debe tener al menos 12 caracteres"
            flash.error = true
            render(view: "register", model: [user: new User(username: params.username, email: params.email)])
            return
        }

        if (rawPassword != params.confirmPassword) {
            flash.message = "Las contraseñas no coinciden"
            flash.error = true
            render(view: "register", model: [user: new User(username: params.username, email: params.email)])
            return
        }

        def user = new User(
                username: params.username?.toString()?.trim(),
                email: params.email?.toString()?.trim()?.toLowerCase(),
                password: passwordEncoder.encode(rawPassword),
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