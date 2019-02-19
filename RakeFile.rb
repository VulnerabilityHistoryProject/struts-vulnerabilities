require_relative "scripts/scraper"

namespace :pull do
  task :cves do
    scraper = StrutsScraper.new()
	scraper.crawl
	scraper.save_cve_ymls
  end
  task :repo do
    Dir.chdir('tmp/') do
      `git clone https://github.com/apache/struts.git`
    end
  end
end
