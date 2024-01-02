require 'httparty'
require 'nokogiri'

@links = {}

def fetch_url_body (url)
	response = HTTParty.get(url)
	Nokogiri::HTML(response.body)
end

def get_article_links ()
	document = fetch_url_body("https://www.placera.se/placera/forstasidan.html")

	document.css('div.cq-puff div').each do |line|
		keyword = line.css('span.arrowRight')
		if keyword.text.include?("Köpråd") or keyword.text.include?("Köptips")
		@links[line.css('h1 a').children.first.text] = 'https://www.placera.se' + line.css('h1 a')[0]['href']
		end
	end
end

# extracts stock recommendations from an article, if possible (table.instrumentSummaryDetails has info)
def extract_stock_recommendations (url)
	document = fetch_url_body(url)
end

#get_article_links()


puts @links
