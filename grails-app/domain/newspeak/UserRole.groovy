// UserRole.groovy
package newspeak

import org.bson.types.ObjectId

class UserRole {
    ObjectId id
    User user
    Role role

    static constraints = {
        user nullable: false
        role nullable: false
    }

    static mapping = {
        collection "user_roles"
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
        UserRole.findAllByUser(user).each {
            it.delete()
        }
    }
}