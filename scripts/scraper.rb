require 'mechanize'

class StrutsScraper

    def initialize()
        @url = "https://cwiki.apache.org/confluence/display/WW/Security+Bulletins"
        @foundPages = {}
	    @cves= Array.new
	    @mech = Mechanize.new
    end

	def crawl()
		page = @mech.get @url
		puts "Crawling: " + page.uri.to_s
		page.links.each do |link|
			# remove all links that aren't to S2s and don't follow links that have
			# labels (to avoid repeating links).
			if(/\/S2-/=~link.href and not /label/=~link.node.to_s)
				#puts link.href
				spage = @mech.get link
				cve_find(spage)
			end
		end
	end

	def cve_find(page)
		html = page.body
		cvematch = /CVE-\d{4}-\d+/.match(html)
		unless cvematch.nil?
			puts "Found: " + cvematch.to_s
			@cves.push(cvematch.to_s)
		end
	end

	def save_cve_ymls()
		@cves.each do |cve|
			unless cve_yml_exists?(cve)
				ymltxt = cve_skeleton_yml.sub("CVE:\n", "CVE: #{cve}\n")
				File.open(as_filename(cve), 'w+') {|file| file.write(ymltxt)}
					puts "Saved #{as_filename(cve)}"
			end
		end
	end

	def cve_skeleton_yml
		File.read(File.expand_path('../skeletons/cve.yml',__dir__))
	end

	def cve_yml_exists?(cve)
		File.exists?(as_filename(cve))
	end

	def as_filename(cve)
	  filename = cve + ".yml"
	  File.join(File.expand_path('../cves/', __dir__), filename)
	end
end
