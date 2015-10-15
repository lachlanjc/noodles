require 'mechanize'
require 'nokogiri'

class AllrecipesSearchScraper
  def scrape(q)
    scraper = Mechanize.new
    scraper.history_added = Proc.new { sleep 0.4 }

    results = []
    raw_results = scraper.get('http://allrecipes.com/search/results/?sort=re&wt=' + q).search('section.grid article.grid-col--fixed-tiles:not(#dfp_container)')
    raw_results.each do |item|
      result = {}
      result['url'] = 'http://allrecipes.com' + item.at_css('a').attr('href')
      result['title'] = item.search('h3').text.strip
      result['description'] = item.search('.rec-card__description').text.strip.truncate(164)
      result['image'] = item.at_css('.grid-col__rec-image').attr('data-original-src')
      results.push(result)
    end
    results.delete_if do |item|
      item['url'].blank? || item['title'].blank?
    end
    results.each do |item|
      item['description'] = item['description'].to_s.truncate(164)
      item['image'] = '' if item['image'].match('http://images.media-allrecipes.com/userphotos/250x250/0.jpg')
    end
    results
  end
end
