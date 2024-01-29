require 'httparty'
require 'nokogiri'
require_relative 'placeraArticle'
#require_relative '../../main'

class PlaceraHandler
    def initialize ()
        @articles = []
    end

    def fetch_url_body (url)
        response = HTTParty.get(url)
        Nokogiri::HTML(response.body)
    end

    # scans for relevant articles
    def find_articles ()
        articles = []
        document = fetch_url_body("https://www.placera.se/placera/forstasidan.html")
        document.css('div.cq-puff div').each do |line|
            keyword = line.css('span.arrowRight')
            if keyword.text.include?("Köp")
                tmp = PlaceraArticle.new(('https://www.placera.se' + line.css('h1 a')[0]['href']), (line.css('h1 a').children.first.text))
                @articles << tmp
            elsif line.css('h1 a').children.first != nil and line.css('h1 a').children.first.text.downcase.include?("köp")
                tmp = PlaceraArticle.new(('https://www.placera.se' + line.css('h1 a')[0]['href']), (line.css('h1 a').children.first.text))
                @articles << tmp
            end
        end
    end

    def get_articles ()
        @articles
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