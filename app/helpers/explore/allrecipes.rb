require 'nokogiri'
require 'wombat'

class AllrecipesSearchScraper
  include Wombat::Crawler

  def scrape(q)
    # q = 'pancakes'
    scraped_data = Wombat.crawl do
      base_url 'http://allrecipes.com'
      path '/search?sort=re&wt=' + q
      results 'css=#searchResultsApp > section.grid.grid-fixed > article:not(#dfp_container)', :iterator do
        title 'css=a > h3.grid-col__h3--recipe-grid'
        description 'css=.rec-card__description'
        url 'css=.grid-col__h3.grid-col__h3--recipe-grid', :html do |u|
          'http://allrecipes.com' + Nokogiri::HTML(u.to_s).at_css('a')['href'].to_s
        end
      end
    end
    scraped_data['results'].delete_if do |item|
      item['title'].blank? || item['url'].blank?
    end
    scraped_data['results']
  end
end
