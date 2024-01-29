require_relative './siteHandler'
require_relative '../articles/privAffArticle'
require 'date'

class PrivAffHandler < SiteHandler
    def initialize ()
        super()
    end

    # scans for relevant articles
    def find_articles ()
        articles = []
        url = "https://www.privataaffarer.se/om/aktierekommendation"
        document = fetch_url_body(url)
        articleList =  document.css('article')
        articleList.each do |article|
            name = article.css('h4.css-1deepoq.eghtsrl0').children.text
            date = article.css('span.css-1d3ncag.e1j1zvi00').children.text
            if name.include?("rekar") and date_relevant?(date)
                artUrl = url + article.css('a.css-11iuz56.etbo9o0')[0]['href']
                @articles << PrivAffArticle.new(artUrl, name, date)
            end
        end
    end

    def date_relevant? (date_str)
        if date_str.include?("Igår") or date_str.include?("Idag")
            return true
        end
        false
    end
end