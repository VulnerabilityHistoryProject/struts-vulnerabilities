require_relative "scraper"
securityPage= "https://cwiki.apache.org/confluence/display/WW/Security+Bulletins"
scraper = StrutsScraper.new(securityPage)
scraper.crawl
scraper.save_cve_ymls