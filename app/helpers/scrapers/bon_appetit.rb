require "wombat"

class BonAppetitScraper
  include Wombat::Crawler

  def scrape(url_path)
    recipe = Wombat.crawl do
      base_url "http://www.bonappetit.com"
      path url_path

      title css: ".content-intro .recipe-title"
      description css: ".content-intro h2"
      ingredients({ css: ".ingredient-set .ingredients li" }, :list)
      instructions({ css: ".prep-steps-container .preparation ul li" }, :list)
      serves css: ".single-recipe .ingredient-sets .total-servings"
    end
    recipe["ingredients"].each { |item| item.gsub!(/\s+/, " ") }
    recipe
  end
end
