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
def extract_stock_recommendations (url)
	document = fetch_url_body(url)
	summary = document.css('table.instrumentSummaryDetails tbody tr') # a.children.first.text => stock name
	i = 0
	while i < 20
		stocks = summary.css('a').children[i].text
		advice = summary.css('td.tRight.plcPositive').children[i].text
		
		i += 1
	end
	#p stocks
end

test = 'https://www.placera.se/placera/redaktionellt/2023/12/29/sexton-kopvarda-aktier-i-januari.html'

extract_stock_recommendations(test)

#get_article_links()
#puts @links
