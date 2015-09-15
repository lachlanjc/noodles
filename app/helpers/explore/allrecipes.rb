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
      result['url'] = 'http://allrecipes.com/recipe/' + item.search('ar-save-item').attr('data-id').to_s
      result['title'] = item.search('h3').text.strip
      result['description'] = item.search('.rec-card__description').text.strip
      results.push(result)
    end
    results.delete_if do |item|
      item['title'].blank?
    end
    results
  end
end
