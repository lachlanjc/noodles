require 'wombat'

class AllRecipesScraper
  include Wombat::Crawler

  def scrape(url_path)
    Wombat.crawl do
      base_url 'http://allrecipes.com'
      path url_path.gsub(/(\/print(\/?)?)(.*)\//, '') + '/print'

      title css: '.recipe-print__title'
      description css: '.recipe-print__description'
      ingredients({ css: '.recipe-print__container2 > ul > li' }, :list)
      instructions({ css: '.recipe-print__directions > li.item' }, :list)
      author css: '.recipe-print__container2 div:first-child span:last-child'
    end
  end
end
