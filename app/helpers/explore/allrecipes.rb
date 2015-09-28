require 'mechanize'
require 'nokogiri'

class AllrecipesSearchScraper
  def scrape(q)
    q = 'pancakes'

    scraper = Mechanize.new
    scraper.history_added = Proc.new { sleep 0.4 }

    results = []
    raw_results = scraper.get('http://allrecipes.com/search/results/?sort=re&wt=' + q).search('section.grid article:not(.dfp_container)')
    raw_results.each do |item|
      result = {}
      # result['url'] = 'http://allrecipes.com/recipe/'
      result['url'] = item.search('a').attr('href').to_s
      result['title'] = item.search('h3').text.strip
      result['description'] = item.search('.rec-card__description').text.strip.truncate(164)
      results.push(result)
    end
    results.delete_if do |item|
      item['url'].blank? || item['title'].blank?
    end
    results
  end
end
