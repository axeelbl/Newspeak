package newspeak

import org.springframework.security.crypto.password.PasswordEncoder

class BootStrap {
    PasswordEncoder passwordEncoder

    def init = { servletContext ->
        // Crear roles si no existen
        def userRole
        if (!Role.findByAuthority('ROLE_USER')) {
            userRole = new Role(authority: 'ROLE_USER').save(flush: true)
        } else {
            userRole = Role.findByAuthority('ROLE_USER')
        }

        def adminRole
        if (!Role.findByAuthority('ROLE_ADMIN')) {
            adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        } else {
            adminRole = Role.findByAuthority('ROLE_ADMIN')
        }

        // Crear usuario de prueba si no existe
        if (!User.findByUsername('admin')) {
            def adminUser = new User(
                    username: 'admin',
                    password: passwordEncoder.encode('admin123'),
                    enabled: true
            ).save(flush: true)

            UserRole.create(adminUser, adminRole, true)
        }

        if (!User.findByUsername('usuario')) {
            def normalUser = new User(
                    username: 'usuario',
                    password: passwordEncoder.encode('usuario123'),
                    enabled: true
            ).save(flush: true)

            UserRole.create(normalUser, userRole, true)
        }
    }

    def destroy = {
    }
}