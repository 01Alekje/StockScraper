require 'httparty'
require 'nokogiri'

# Fetching response from Avanza's newspage
response = HTTParty.get("https://www.placera.se/placera/forstasidan.html")

# Parse some shit and stuff, yeah
document = Nokogiri::HTML(response.body)

articles = document.css("div.cq-puff")

document.css('div.cq-puff div').each do |line|
  keyword = line.css('span.arrowRight')
  if keyword.text.include?("Köpråd") or keyword.text.include?("Köptips")
    puts line.css('h1')
  end
end
