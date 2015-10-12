require 'nokogiri'
require 'wombat'

class NYTSearchScraper
  include Wombat::Crawler

  def scrape(q)
    scraped_data = Wombat.crawl do
      base_url 'http://cooking.nytimes.com'
      path '/search?q=' + q

      results 'css=#search-results .recipe-card-list .recipe-card', :iterator do
        title 'css=h3.name'
        description 'css=.card-byline'
        image 'css=.image', :html
        url 'css=*', :html
      end
    end
    scraped_data['results'].delete_if do |item|
      item['title'].blank?
    end
    scraped_data['results'].each do |result|
      src = 'http://cooking.nytimes.com' + Nokogiri::HTML(result['url'].to_s).at_css('a')['href'].to_s
      result['url'] = src
      result['description'] = result['description'].to_s.truncate(164)
      result['image'] = '' if result['image'].match('pattern')
      if result['image'].to_s.length > 2
        result['image'] = Nokogiri::HTML(result['image'].to_s).at_css('img').attributes['data-large'].value
      end
    end
    scraped_data['results']
  end
end
