require 'wombat'

class AllRecipesScraper
  include Wombat::Crawler

  def scrape(url_path)
    return Wombat.crawl do
      base_url "http://allrecipes.com"
      path url_path

      title css: ".rec-detail-wrapper h1"
      description css: ".rec-detail-wrapper #divAuthorContainer #lblDescription"
      ingredients({ css: ".ingredient-wrap #liIngredient" }, :list)
      instructions({ css: ".directions ol li" }, :list)
      serves css: ".servings #lblYield"
    end
  end
end
