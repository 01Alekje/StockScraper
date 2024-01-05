require 'httparty'
require 'nokogiri'
require_relative 'article'
require_relative 'siteHandlers/placeraHandler'

# Initializing data
@placeraHandler = PlaceraHandler.new()

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

@placeraHandler.find_articles()
articles = @placeraHandler.get_articles()
puts articles

articles.each do |article|
	@placeraHandler.extract_stock_recommendations(article)
	p article.get_name()
	p article.get_date()
	#p article.get_stock_recommendations()
end

#p find_intersections(articles)
