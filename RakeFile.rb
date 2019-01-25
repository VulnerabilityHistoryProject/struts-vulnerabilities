require_relative "scripts/scraper"

namespace :pull do
  task :cves do
    scraper = StrutsScraper.new()
	scraper.crawl
	scraper.save_cve_ymls
  end
end