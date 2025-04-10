// Role.groovy
package newspeak

import org.bson.types.ObjectId

class Role {
    ObjectId id
    String authority

    static constraints = {
        authority blank: false, unique: true
    }

    static mapping = {
        collection "roles"
    }
}