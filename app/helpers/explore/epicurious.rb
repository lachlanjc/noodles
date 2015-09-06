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
        url 'css=.sr_title', :html
      end
    end
    scraped_data['results'].delete_if do |item|
      item['title'].blank?
    end
    scraped_data['results'].each do |result|
      result['url'] = 'http://epicurious.com' + Nokogiri::HTML(result['url'].to_s).at_css('a')['href'].to_s
      result['description'] = result['description'].gsub(/\s+/, " ")
    end
    scraped_data['results']
  end
end
