require_relative './siteArticle'

class PlaceraArticle < SiteArticle
    def initialize (url, name)
        super(url, name)
    end

    # extracts stock recommendations from a PlaceraArticle, if possible (table.instrumentSummaryDetails has info)
    def extract_stock_recommendations ()
        document = fetch_url_body(get_url())
        date = document.css('p.articleDate.XSText span').children.first.text
        set_date(parse_date(date))
        document.css('table.instrumentSummaryDetails tbody tr').each do |row|
            st_name = row.css('a').children.first.text
            st_advice = row.css('td.tRight').children.first.text
            add_stock_recommendation(st_name, st_advice)
        end
    end

    def parse_date (date_str)
        date_str.gsub("\n", '').gsub("\r", '')
    end
end