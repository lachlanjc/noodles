require 'nokogiri'
require 'wombat'

class EpicuriousSearchScraper
  include Wombat::Crawler

  def scrape(q)
    scraper = Mechanize.new
    scraper.history_added = Proc.new { sleep 0.4 }

    results = []
    page = scraper.get('http://epicurious.com/tools/searchresults?search=' + q)
    raw_results = page.search('#searchresults #recipe_main .sr_rows')
    raw_results.each do |item|
      result = {}
      result['url'] = 'http://epicurious.com' + item.at_css('a').attr('href').to_s
      result['title'] = item.search('.sr_title a').text.strip
      result['description'] = item.search('.sr_source').text.strip.gsub(/\s+/, ' ').truncate(164)
      result['image'] = item.at_css('img').attr('src')
      results.push(result)
    end
    results.delete_if { |item| item['url'].blank? || item['title'].blank? }
    results.each do |result|
      if result['image'].match('/i/recipe-img-icon')
        result['image'] = ''
      else
        s = result['image']
        s.gsub!(/_116/, '')
        s.gsub!(/_120/, '_500')
        result['image'] = s.match('assets') ? s : 'http://epicurious.com' + s
      end
    end
    results
  end
end
