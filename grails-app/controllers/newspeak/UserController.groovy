package newspeak

import org.springframework.security.crypto.password.PasswordEncoder

class UserController {

    def springSecurityService
    PasswordEncoder passwordEncoder // Inyectar el codificador de contraseñas

    // Ya no necesitas esta acción para login si usas Spring Security correctamente
    def login() {
        if (springSecurityService.isLoggedIn()) {
            redirect(controller: 'home', action: 'index')
            return
        }
        render(view: "login")
    }

    // La autenticación debería ser manejada por Spring Security
    def auth() {
        // Este método debería ser manejado por la configuración de Spring Security
        // Sólo se usa para mostrar errores de login
        render(view: 'login')
    }

    // Acción para registro
    def register() {
        render(view: 'register', model: [user: new User()])
    }

    // Acción para guardar un nuevo usuario
    def save() {
        if (params.password != params.confirmPassword) {
            flash.message = "Las contraseñas no coinciden"
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
            render(view: "register", model: [user: user])
        }
    }

    // Logout (opcional, normalmente manejado por Spring Security)
    def logout() {
        redirect(uri: '/j_spring_security_logout')
    }
}