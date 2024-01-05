require_relative '../article'

class SiteHandler
    def initialize ()
        @articles = []
    end

    def get_articles ()
        @articles
    end

    def add_article (article)
        @articles << article
    end
end