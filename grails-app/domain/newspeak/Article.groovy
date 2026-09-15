package newspeak

import org.bson.types.ObjectId

class Article {
    ObjectId id
    String title
    String description
    String content
    String imageUrl
    User author
    Date dateCreated
    Date lastUpdated
    boolean published = false

    static constraints = {
        title blank: false, maxSize: 200
        description blank: false, maxSize: 1000
        content blank: false, maxSize: 50000
        imageUrl nullable: true, blank: true, maxSize: 2048, validator: { value ->
            if (value && !(value ==~ /^https?:\/\/.+/)) {
                return 'url.invalid'
            }
        }
        author nullable: false
    }

    static mapping = {
        collection "articles"
    }
}