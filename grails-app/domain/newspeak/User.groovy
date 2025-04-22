package newspeak

import org.bson.types.ObjectId
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.UserDetails

class User implements UserDetails {
    ObjectId id
    String username
    String email  // Asegúrate de que este campo esté aquí
    String password
    boolean enabled = true
    boolean accountExpired = false
    boolean accountLocked = false
    boolean passwordExpired = false

    static constraints = {
        username blank: false, unique: true
        email email: true, blank: false, unique: true  // Y estas restricciones
        password blank: false
    }

    static mapping = {
        collection "users"
    }

    Collection<? extends GrantedAuthority> getAuthorities() {
        UserRole.findAllByUser(this).collect {
            new SimpleGrantedAuthority(it.role.authority)
        }
    }

    boolean isAccountNonExpired() {
        return !accountExpired
    }

    boolean isAccountNonLocked() {
        return !accountLocked
    }

    boolean isCredentialsNonExpired() {
        return !passwordExpired
    }
}