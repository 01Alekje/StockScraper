require 'httparty'
require 'nokogiri'
require_relative 'article'

def fetch_url_body (url)
	response = HTTParty.get(url)
	Nokogiri::HTML(response.body)
end

# scans for relevant articles (todo: find more of the relevant articles)
def get_article_links ()
	@articles = []
	document = fetch_url_body("https://www.placera.se/placera/forstasidan.html")

	document.css('div.cq-puff div').each do |line|
		keyword = line.css('span.arrowRight')
		if keyword.text.include?("Köpråd") or keyword.text.include?("Köptips")
			tmp = Article.new(('https://www.placera.se' + line.css('h1 a')[0]['href']), (line.css('h1 a').children.first.text))
			@articles << tmp
		end
	end
	@articles
end

# extracts stock recommendations from an article, if possible (table.instrumentSummaryDetails has info)
def extract_stock_recommendations (article)
	document = fetch_url_body(article.getUrl())
	document.css('table.instrumentSummaryDetails tbody tr').each do |row|
		st_name = row.css('a').children.first.text
		st_advice = row.css('td.tRight.plcPositive').children.first.text
		article.add_stock_recommendation(st_name, st_advice)
	end
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

articles = get_article_links()

articles.each do |article|
	extract_stock_recommendations(article)
end

p find_intersections(articles)
