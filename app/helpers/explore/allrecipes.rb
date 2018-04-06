class AllrecipesSearchScraper
  PLACEHOLDERS = [
    'http://images.media-allrecipes.com/images/44555.png',
    'http://images.media-allrecipes.com/userphotos/250x250/0.jpg'
  ].freeze
  SELECTOR = '.search-results .recipe-section article.fixed-recipe-card:not(.grid-col--fixed-tiles):not(.video-card):not(.hub-card)'.freeze
  IMG_SELECTOR = '.fixed-recipe-card__img'.freeze

  def scrape(q)
    scraper = Mechanize.new
    scraper.history_added = proc { sleep 0.25 }

    results = []
    url = "http://allrecipes.com/search/results/?sort=re&wt=#{q}"
    scraper.get(url).search(SELECTOR).each do |item|
      next if item.at_css('div').attr('class').to_s.match?('article-card')
      result = {}
      result['url'] = "http://allrecipes.com#{item.at_css('a').attr('href')}"
      result['title'] = item.search('h3').text.squish
      result['description'] = item.search('.fixed-recipe-card__description').text.squish.truncate(164)
      if item.at_css(IMG_SELECTOR).present?
        result['image'] = item.at_css(IMG_SELECTOR).attr('data-original-src')
        if result['image'].blank?
          result['image'] = item.at_css(IMG_SELECTOR).attr('src')
          result['image'] = nil if result['image'].include? 'spacer.gif'
        end
      end
      results.push(result)
    end
    results.delete_if { |item| !item['url'] || !item['title'] }.compact!
    results.each do |item|
      item['description'] = item['description'].to_s.truncate(164)
      item['image'] = '' if PLACEHOLDERS.include? item['image'].to_s
    end
    results
  end
end
