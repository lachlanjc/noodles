class NYTSearchScraper
  def scrape(q)
    scraper = Mechanize.new
    scraper.history_added = proc { sleep 0.25 }

    results = []
    search = URI.encode(q).gsub /\%20/, '+'
    raw_results = scraper.get "http://cooking.nytimes.com/search?q=#{search}"
    raw_results = raw_results.search('#search-results .recipe-card:not(.ad-container)')
    raw_results.each do |item|
      result = {}
      result['url'] = "http://cooking.nytimes.com#{item.at_css('a').attr('href')}"
      result['title'] = item.search('h3').text.squish
      result['description'] = item.search('h3 + p').text.squish.truncate(164)
      if item.search('.cooking-time').any?
        result['description'] += ' – ' + item.at_css('.cooking-time').text.squish
      end
      if item.search('.sticker').any?
        result['description'] += ' – ' + item.search('.sticker').text.squish
      end
      result['image'] = item.at_css('img').attr('data-src')
      result['image'] = '' if result['image'].to_s.match?('pattern')
      results.push(result)
    end
    results.delete_if { |item| !item['url'] || !item['title'] }.compact!
    results
  end
end
