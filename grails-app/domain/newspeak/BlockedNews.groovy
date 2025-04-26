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
        url blank: false, unique: true
        reason nullable: true
        dateBlocked nullable: true
        blockedBy nullable: true
    }

    static mapping = {
        collection "blocked_news"
    }
}