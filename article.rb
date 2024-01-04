class Article
    def initialize (url, name)
        @url = url
        @name = name
        @stocks = {}
    end

    def getUrl ()
        @url
    end

    def getName ()
        @name
    end

    def get_stock_recommendations ()
        @stocks
    end

    def add_stock_recommendation (st_name, st_advice)
        @stocks[st_name] = st_advice
    end
end