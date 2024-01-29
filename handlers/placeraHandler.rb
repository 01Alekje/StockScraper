require 'httparty'
require 'nokogiri'
require_relative '../articles/placeraArticle'
require_relative './siteHandler'

class PlaceraHandler < SiteHandler
    def initialize ()
        super()
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
end