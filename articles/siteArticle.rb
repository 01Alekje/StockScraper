class SiteArticle
    def initialize (url, name, date=nil)
        @url = url
        @name = name
        @stocks = {}
        @date = date
    end

    def get_url ()
        @url
    end

    def get_name ()
        @name
    end

    def get_date ()
        @date
    end

    def set_date (date)
        @date = date
    end

    def get_stock_recommendations ()
        @stocks
    end

    def add_stock_recommendation (st_name, st_advice)
        @stocks[st_name] = st_advice
    end

    def fetch_url_body (url)
        response = HTTParty.get(url)
        Nokogiri::HTML(response.body)
    end
end