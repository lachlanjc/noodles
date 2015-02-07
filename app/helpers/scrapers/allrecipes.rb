require 'wombat'

class AllRecipesScraper
  include Wombat::Crawler

  def scrape(url_path)
    recipe = Wombat.crawl do
      base_url "http://allrecipes.com"
      path url_path

      title css: ".rec-detail-wrapper h1"
      description css: ".rec-detail-wrapper #divAuthorContainer #lblDescription"
      ingredients_raw({ css: ".ingredient-wrap #liIngredient" }, :list)
      instructions({ css: ".directions ol li" }, :list)
      serves css: ".servings #lblYield"
    end
    recipe["ingredients"] = recipe["ingredients_raw"]
    recipe["ingredients"].each do |line|
      16.times { line.sub!(/\s\s/, "") }
    end
    recipe.delete("ingredients_raw")
    return recipe
  end
end
