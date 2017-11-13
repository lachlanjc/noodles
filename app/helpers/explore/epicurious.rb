require 'nokogiri'
require 'wombat'

class EpicuriousSearchScraper
  def scrape(q)
    scraper = Mechanize.new
    scraper.history_added = proc { sleep 0.4 }

    results = []
    search = URI.encode(q).gsub /\%20/, '+'
    raw_results = scraper.get "http://epicurious.com/tools/searchresults?search=#{search}"
    raw_results = raw_results.search('.sr_main .sr_rows')
    raw_results.each do |item|
      result = {}
      result['url'] = 'http://epicurious.com' + item.at_css('a').attr('href').to_s
      result['title'] = item.search('.sr_title a').text.squish
      result['description'] = item.search('.sr_source').text.squish.gsub(/\s+/, ' ').truncate(164)
      result['image'] = item.at_css('img').attr('src')
      results.push(result)
    end
    results.delete_if { |item| item['url'].blank? || item['title'].blank? }
    results.each { |item| fix_image(item) }
    results
  end

  protected

  def fix_image(result)
    if result['image'].match?(/\/i\/recipe\-img\-icon/)
      result['image'] = ''
    else
      s = result['image']
      s.gsub! /_116/, ''
      s.gsub! /_120/, '_500'
      result['image'] = s.match?(/assets/) ? s : 'http://epicurious.com' + s
    end
    result
  end
end
