require 'httparty'
require 'nokogiri'
require_relative 'handlers/placeraHandler'

# Initializing data
@ph = PlaceraHandler.new()

def fetch_url_body (url)
	response = HTTParty.get(url)
	Nokogiri::HTML(response.body)
end

# finds stocks that where recommended by more than one article
def find_intersections (articles)
	intersections = []
	i = 0
	while i < articles.length
		articles[i].get_stock_recommendations.each do |stock|
			j = i + 1
			while j < articles.length
				if articles[j].get_stock_recommendations()[stock[0]] != nil
					intersections << stock[0]
				end
				j += 1
			end
		end
		i += 1
	end
	intersections
end

@ph.find_articles()
@ph.get_stock_recommendations()
@ph.display_articles()
