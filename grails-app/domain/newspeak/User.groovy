package newspeak

import org.bson.types.ObjectId
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.UserDetails

class User implements UserDetails {

    ObjectId id
    String username
    String password
    boolean enabled = true
    boolean accountExpired = false
    boolean accountLocked = false
    boolean passwordExpired = false

    static constraints = {
        username blank: false, unique: true
        password blank: false
    }

    static mapping = {
        id generator: 'org.hibernate.id.UUIDGenerator'
    }

    @Override
    String getUsername() {
        return username
    }

    @Override
    boolean isAccountNonExpired() {
        return !accountExpired
    }

    @Override
    boolean isAccountNonLocked() {
        return !accountLocked
    }

    @Override
    boolean isCredentialsNonExpired() {
        return !passwordExpired
    }

    @Override
    boolean isEnabled() {
        return enabled
    }

    @Override
    Collection<? extends GrantedAuthority> getAuthorities() {
        // Obtener las autoridades desde UserRole
        UserRole.findAllByUser(this).collect {
            new SimpleGrantedAuthority(it.role.authority)
        }
    }

    @Override
    String getPassword() {
        return password
    }
}