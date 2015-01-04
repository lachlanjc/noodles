require 'wombat'

class AllRecipesScraper
  include Wombat::Crawler

  def scrape(url_path)
    return Wombat.crawl do
      base_url "http://allrecipes.com"
      path url_path

      title css: ".rec-detail-wrapper h1"
      description css: ".rec-detail-wrapper #divAuthorContainer #lblDescription"
      ingredients_raw({ css: ".ingredient-wrap #liIngredient" }, :list)
      instructions({ css: ".directions ol li" }, :list)
      serves css: ".servings #lblYield"
    end
  end
end

def scrape_and_process(url_path)
  allrecipes = AllRecipesScraper.new.scrape(url_path)
  allrecipes["ingredients"] = allrecipes["ingredients_raw"]
  allrecipes["ingredients"].each do |line|
    line.sub!(/\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s\s/, " ")
  end
  allrecipes.delete("ingredients_raw")
  return allrecipes
end
