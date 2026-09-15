// BlockedNews.groovy
package newspeak

import org.bson.types.ObjectId

class BlockedNews {
    ObjectId id
    String url
    String reason
    Date dateBlocked
    String blockedBy

    static constraints = {
        url blank: false, unique: true, maxSize: 2048, validator: { value ->
            if (!(value ==~ /^https?:\/\/.+/) && !(value ==~ /^\/article\/view\/.+/)) {
                return 'url.invalid'
            }
        }
        reason nullable: true, maxSize: 500
        dateBlocked nullable: true
        blockedBy nullable: true, maxSize: 100
    }

    static mapping = {
        collection "blocked_news"
    }
}