package newspeak

import org.springframework.security.crypto.password.PasswordEncoder

class BootStrap {

    PasswordEncoder passwordEncoder

    def init = { servletContext ->
        // Crea los roles si no existen
        def userRole = Role.findByAuthority('ROLE_USER') ?: new Role(authority: 'ROLE_USER').save(flush: true)
        def adminRole = Role.findByAuthority('ROLE_ADMIN') ?: new Role(authority: 'ROLE_ADMIN').save(flush: true)

        // Crea un usuario administrador si no existe
        if (!User.findByUsername('admin')) {
            def adminUser = new User(
                    username: 'admin',
                    password: passwordEncoder.encode('admin123'),
                    enabled: true
            ).save(flush: true)

            UserRole.create(adminUser, adminRole, true)
            println "Usuario admin creado"
        }
    }

    def destroy = {
    }
}