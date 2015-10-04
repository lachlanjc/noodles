require 'wombat'

class Food52Scraper
  include Wombat::Crawler

  def scrape(url_path)
    Wombat.crawl do
      base_url 'http://food52.com'
      path url_path

      title css: 'h1[itemprop=name]'
      ingredients({ css: '.recipe-list li' }, :list)
      instructions({ css: 'ol li[itemprop=recipeInstructions]' }, :list)
      serves css: 'p[itemprop=recipeYield]'

      notes css: '.recipe-note'
    end
  end
end
