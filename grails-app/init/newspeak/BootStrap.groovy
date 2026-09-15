package newspeak

import org.springframework.security.crypto.password.PasswordEncoder

class BootStrap {
    PasswordEncoder passwordEncoder
    def grailsApplication

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

        // Crear rol de escritor si no existe
        def writerRole
        if (!Role.findByAuthority('ROLE_WRITER')) {
            writerRole = new Role(authority: 'ROLE_WRITER').save(flush: true)
        } else {
            writerRole = Role.findByAuthority('ROLE_WRITER')
        }

        if (!grailsApplication.config.newspeak.demoUsers.enabled) {
            return
        }

        def demoPasswords = [
                admin: grailsApplication.config.newspeak.demoUsers.adminPassword?.toString(),
                usuario: grailsApplication.config.newspeak.demoUsers.userPassword?.toString(),
                escritor: grailsApplication.config.newspeak.demoUsers.writerPassword?.toString()
        ]
        if (demoPasswords.values().any { !it || it.length() < 12 }) {
            log.warn('Demo users were not created: all demo passwords must contain at least 12 characters')
            return
        }

        // Crear usuarios de demostración solo cuando se habiliten explícitamente
        if (!User.findByUsername('admin')) {
            def adminUser = new User(
                    username: 'admin',
                    email: 'admin@newspeak.com',
                    password: passwordEncoder.encode(demoPasswords.admin),
                    enabled: true
            ).save(flush: true)

            UserRole.create(adminUser, adminRole, true)
        }

        if (!User.findByUsername('usuario')) {
            def normalUser = new User(
                    username: 'usuario',
                    email: 'usuario@newspeak.com',
                    password: passwordEncoder.encode(demoPasswords.usuario),
                    enabled: true
            ).save(flush: true)

            UserRole.create(normalUser, userRole, true)
        }

        // Crear un escritor de prueba
        if (!User.findByUsername('escritor')) {
            def writerUser = new User(
                    username: 'escritor',
                    email: 'escritor@newspeak.com',
                    password: passwordEncoder.encode(demoPasswords.escritor),
                    enabled: true
            ).save(flush: true)

            UserRole.create(writerUser, userRole, true)
            UserRole.create(writerUser, writerRole, true)
        }
    }

    def destroy = {
    }
}