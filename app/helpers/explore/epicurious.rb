require 'nokogiri'
require 'wombat'

class EpicuriousSearchScraper
  include Wombat::Crawler

  def scrape(q)
    scraped_data = Wombat.crawl do
      base_url 'http://epicurious.com'
      path '/tools/searchresults?search=' + q

      results 'css=#searchresults #recipe_main .sr_rows', :iterator do
        title 'css=.sr_title a'
        description 'css=.sr_source'
        image 'css=a:first-child', :html
        url 'css=.sr_title', :html
      end
    end
    scraped_data['results'].delete_if { |item| item['title'].blank? || item['url'].blank? }
    scraped_data['results'].each do |result|
      result['url'] = 'http://epicurious.com' + Nokogiri::HTML(result['url'].to_s).at_css('a')['href'].to_s
      result['description'] = result['description'].gsub(/\s+/, ' ').truncate(164)
      if result['image'].to_s.length > 2
        s = Nokogiri::HTML(result['image'].to_s).at_css('img').attributes['src'].value
        s.gsub!(/_116/, '')
        s.gsub!(/_120/, '_500')
        result['image'] =  s.match('assets') ? s : 'http://epicurious.com' + s
      end
    end
    scraped_data['results']
  end
end
