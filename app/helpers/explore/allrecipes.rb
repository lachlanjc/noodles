require 'mechanize'
require 'nokogiri'

class AllrecipesSearchScraper
  def scrape(q)
    q = 'pancakes'

    scraper = Mechanize.new
    scraper.history_added = Proc.new { sleep 0.4 }
    base_url = 'http://allrecipes.com'
    raw_data = []
    results = []
  end
end
