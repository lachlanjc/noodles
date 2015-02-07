require "wombat"

class EpicuriousScraper
  include Wombat::Crawler

  def scrape(url_path)
    recipe = Wombat.crawl do
      base_url "http://epicurious.com"
      path url_path

      title css: "#headline h1"
      description css: "#recipe_summary #recipeIntroText p"
      ingredients({ css: ".ingredientsList .ingredient" }, :list)
      instructions({ css: ".instructions > p" }, :list)
      # source css: ".instructions #additional-info .recipe-source-info"
      serves css: "#recipe_summary .summary_data span"
    end
    recipe["instructions"].each do |line|
      # Removes their step numbers
      line.sub!(/\d\.\s/, "")
    end
    return recipe
  end
end
