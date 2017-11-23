class EpicuriousSearchScraper
  def scrape(q)
    scraper = Mechanize.new
    scraper.history_added = proc { sleep 0.25 }

    results = []
    search = URI.encode(q).gsub /\%20/, '+'
    raw_results = scraper.get "https://www.epicurious.com/search/#{search}?content=recipe"
    raw_results = raw_results.search('.results-group .recipe-content-card')
    raw_results.each do |item|
      result = {}
      result['url'] = "http://epicurious.com#{item.at_css('a').attr('href')}"
      result['title'] = item.search('h4').text.squish
      result['description'] = item.search('p').text.squish.truncate(164)
      results.push(result)
    end
    results.delete_if { |item| item['url'].blank? || item['title'].blank? }
    results
  end
end
