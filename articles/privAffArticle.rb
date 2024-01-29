require_relative './siteArticle'

class PrivAffArticle < SiteArticle
    def initialize (url, name, date=nil)
        super(url, name, date)
    end
end