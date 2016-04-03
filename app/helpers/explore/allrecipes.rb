require 'mechanize'
require 'nokogiri'

class AllrecipesSearchScraper
  def scrape(q)
    scraper = Mechanize.new
    scraper.history_added = proc { sleep 0.4 }

    results = []
    raw_results = scraper.get('http://allrecipes.com/search/results/?sort=re&wt=' + q).search('section.grid article.grid-col--fixed-tiles:not(#dfp_container)')
    raw_results.each do |item|
      result = {}
      result['url'] = 'http://allrecipes.com' + item.at_css('a').attr('href')
      result['title'] = item.search('h3').text.squish
      result['description'] = item.search('.rec-card__description').text.squish.truncate(164)
      if item.at_css('.grid-col__rec-image').present?
        result['image'] = item.at_css('.grid-col__rec-image').attr('data-original-src')
      elsif item.at_css('.grid-col__hub-image').present?
        result['image'] = item.at_css('.grid-col__hub-image').attr('src')
      end
      results.push(result)
    end
    results.delete_if do |item|
      item['url'].blank? || item['title'].blank?
    end
    results.each do |item|
      item['description'] = item['description'].to_s.truncate(164)
      placeholder = 'http://images.media-allrecipes.com/userphotos/250x250/0.jpg'
      item['image'] = '' if item['image'] =~ /#{Regexp.quote(placeholder)}/
    end
    results
  end
end
