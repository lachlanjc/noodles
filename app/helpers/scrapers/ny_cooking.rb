require "wombat"

class NYCookingScraper
  include Wombat::Crawler

  def scrape(url_path)
    recipe = Wombat.crawl do
      base_url "http://cooking.nytimes.com"
      path url_path

      title css: ".recipe-title"
      ingredients_raw({ css: ".recipe-ingredients li" }, :list)
      instructions({ css: ".recipe-steps li" }, :list)
      serves css: ".recipe-time-yield span[itemprop=\"recipeYield\"]"

      notes css: ".recipe-note-description"
    end
    recipe["ingredients"] = recipe["ingredients_raw"]
    recipe.delete("ingredients_raw")
    recipe["ingredients"].each do |line|
      8.times { line.sub!(/\n/, " ") }
    end
    return recipe
  end
end
