package newspeak

import grails.testing.web.controllers.ControllerUnitTest
import spock.lang.Specification

class ErrorControllerSpec extends Specification implements ControllerUnitTest<ErrorController> {

    void 'renders the generic error page'() {
        when:
        controller.error()

        then:
        view == '/error'
    }
}
