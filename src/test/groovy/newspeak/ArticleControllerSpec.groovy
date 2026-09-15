package newspeak

import grails.testing.gorm.DomainUnitTest
import grails.testing.web.controllers.ControllerUnitTest
import spock.lang.Specification

class ArticleControllerSpec extends Specification implements ControllerUnitTest<ArticleController>, DomainUnitTest<Article> {

    void 'redirects when an article does not exist'() {
        when:
        controller.view()

        then:
        response.redirectedUrl == '/home'
        flash.error == 'Artículo no encontrado'
    }
}
