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
        title blank: false
        description blank: false
        content blank: false
        imageUrl nullable: true
        author nullable: false
    }

    static mapping = {
        collection "articles"
    }
}