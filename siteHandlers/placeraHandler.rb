require_relative '../article'
require_relative 'sitehandler'

class PlaceraHandler < SiteHandler
    # scans for relevant articles
    def find_articles ()
        document = fetch_url_body("https://www.placera.se/placera/forstasidan.html")
        document.css('div.cq-puff div').each do |line|
            keyword = line.css('span.arrowRight')
            if keyword.text.include?("Köp")
                add_article(Article.new(('https://www.placera.se' + line.css('h1 a')[0]['href']), (line.css('h1 a').children.first.text)))
            elsif line.css('h1 a').children.first != nil and line.css('h1 a').children.first.text.downcase.include?("köp")
                add_article(Article.new(('https://www.placera.se' + line.css('h1 a')[0]['href']), (line.css('h1 a').children.first.text)))
            end
        end
    end

    # extracts stock recommendations from an article, if possible (table.instrumentSummaryDetails has info)
    def extract_stock_recommendations (article)
        document = fetch_url_body(article.get_url())
        document.css('table.instrumentSummaryDetails tbody tr').each do |row|
            st_name = row.css('a').children.first.text
            st_advice = row.css('td.tRight').children.first.text
            article.add_stock_recommendation(st_name, st_advice)
        end
    end
end