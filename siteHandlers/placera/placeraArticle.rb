class PlaceraArticle

    def initialize (url, name)
        @url = url
        @name = name
        @stocks = {}
        @date = nil
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

    # extracts stock recommendations from an article, if possible (table.instrumentSummaryDetails has info)
    def extract_stock_recommendations ()
        document = fetch_url_body(get_url())
        date = document.css('p.articleDate.XSText span').children.first.text
        #set_date(date) # date keeps newlines and stuff for some reason
        set_date(parse_date(date))
        document.css('table.instrumentSummaryDetails tbody tr').each do |row|
            st_name = row.css('a').children.first.text
            st_advice = row.css('td.tRight').children.first.text
            add_stock_recommendation(st_name, st_advice)
        end
    end

    def parse_date (date_str)
        date_str.gsub("\n", '').gsub("\r", '')
    end
end