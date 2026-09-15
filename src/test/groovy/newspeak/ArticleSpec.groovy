package newspeak

import grails.testing.gorm.DomainUnitTest
import spock.lang.Specification

class ArticleSpec extends Specification implements DomainUnitTest<Article> {

    void 'accepts an HTTPS image URL'() {
        given:
        def article = validArticle('https://example.com/image.jpg')

        expect:
        article.validate()
    }

    void 'rejects a non-HTTP image URL'() {
        given:
        def article = validArticle('javascript:alert(1)')

        expect:
        !article.validate()
        article.errors.getFieldError('imageUrl').code == 'url.invalid'
    }

    void 'enforces content length limits'() {
        given:
        def article = validArticle(null)
        article.title = 'x' * 201

        expect:
        !article.validate()
        article.errors.hasFieldErrors('title')
    }

    private static Article validArticle(String imageUrl) {
        new Article(
                title: 'Título',
                description: 'Descripción',
                content: 'Contenido',
                imageUrl: imageUrl,
                author: new User(username: 'writer', email: 'writer@example.com', password: 'hash')
        )
    }
}
