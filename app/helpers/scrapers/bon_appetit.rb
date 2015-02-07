require "wombat"

class BonAppetitScraper
  include Wombat::Crawler

  def scrape(url_path)
    recipe = Wombat.crawl do
      base_url "http://www.bonappetit.com"
      path url_path

      title css: ".content-intro .recipe-title"
      description css: ".content-intro h2"
      ingredients_raw({ css: ".ingredient-set .ingredients li" }, :list)
      instructions({ css: ".prep-steps-container .preparation ul li" }, :list)
      serves css: ".single-recipe .ingredient-sets .total-servings"
    end
    recipe = scrape(url_path)
    recipe["ingredients"] = recipe["ingredients_raw"]
    recipe["ingredients"].each do |line|
      2.times do
        line.sub!(/\n/, " ")
      end
    end
    recipe.delete("ingredients_raw")
    return recipe
  end
end
