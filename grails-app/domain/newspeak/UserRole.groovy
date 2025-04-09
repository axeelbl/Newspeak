package newspeak

class UserRole {
    User user
    Role role

    static mapping = {
        id composite: ['user', 'role']
    }

    static constraints = {
        user nullable: false
        role nullable: false
        version false
    }

    static UserRole create(User user, Role role, boolean flush = false) {
        def instance = new UserRole(user: user, role: role)
        instance.save(flush: flush, insert: true)
        instance
    }

    static boolean remove(User user, Role role, boolean flush = false) {
        UserRole instance = UserRole.findByUserAndRole(user, role)
        if (!instance) {
            return false
        }
        instance.delete(flush: flush)
        true
    }

    static void removeAll(User user) {
        executeUpdate 'DELETE FROM UserRole WHERE user=:user', [user: user]
    }
}