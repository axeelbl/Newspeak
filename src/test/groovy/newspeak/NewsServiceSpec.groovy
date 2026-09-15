package newspeak

import grails.testing.gorm.DomainUnitTest
import grails.testing.services.ServiceUnitTest
import spock.lang.Specification

class NewsServiceSpec extends Specification implements ServiceUnitTest<NewsService>, DomainUnitTest<BlockedNews> {

    void 'does not call NewsAPI without a configured key'() {
        given:
        grailsApplication.config.newsapi.key = ''

        expect:
        service.fetchApiArticles('actualidad') == []
    }

    void 'rejects unsafe blocked-news URLs'() {
        expect:
        !service.blockNews('javascript:alert(1)', 'unsafe', 'admin')
        BlockedNews.count() == 0
    }

    void 'stores and removes a valid blocked-news URL'() {
        given:
        def url = 'https://example.com/article'

        expect:
        service.blockNews(url, 'duplicada', 'admin')
        BlockedNews.count() == 1
        service.unblockNews(url)
        BlockedNews.count() == 0
    }
}
