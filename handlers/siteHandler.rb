class SiteHandler
    def initialize ()
        @articles = []
    end

    def fetch_url_body (url)
        response = HTTParty.get(url)
        Nokogiri::HTML(response.body)
    end

    def get_articles ()
        @articles
    end

    def add_article (article)
        @articles << article
    end


    def get_stock_recommendations ()
        @articles.each do |article|
            article.extract_stock_recommendations()
        end
    end

    def display_articles ()
        @articles.each do |article|
            puts article.get_name()
            puts article.get_date()
            puts article.get_stock_recommendations()
            puts "\n"
        end
    end
end