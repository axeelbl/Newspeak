package newspeak

import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService as SpringUserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.stereotype.Service
import grails.gorm.transactions.Transactional

@Service
@Transactional(readOnly = true)
class UserDetailsService implements SpringUserDetailsService {

    @Override
    UserDetails loadUserByUsername(String login) throws UsernameNotFoundException {
        User user = User.findByUsername(login)

        if (!user) {
            // Si no se encuentra por username, buscar por email
            user = User.findByEmail(login)

            if (user) {
                // Si lo encontramos por email, asegurarnos de que Spring Security
                // pueda hacer la validación correctamente
                return new org.springframework.security.core.userdetails.User(
                        user.username,  // Importante: mantener el username real para Spring Security
                        user.password,
                        user.enabled,
                        !user.accountExpired,
                        !user.passwordExpired,
                        !user.accountLocked,
                        user.getAuthorities()
                )
            }
        }

        if (!user) {
            throw new UsernameNotFoundException("Usuario no encontrado con el nombre de usuario o correo: ${login}")
        }

        return user
    }
}