require 'wombat'

class BonAppetitScraper
  include Wombat::Crawler

  def scrape(url_path)
    return Wombat.crawl do
      base_url "http://www.bonappetit.com"
      path url_path

      title css: ".content-intro .recipe-title"
      description css: ".content-intro h2"
      ingredients_raw({ css: ".ingredient-set .ingredients li" }, :list)
      instructions({ css: ".prep-steps-container .preparation ul li" }, :list)
      serves css: ".single-recipe .ingredient-sets .total-servings"
    end
  end

  def scrape_and_process(url_path)
    bonappetit = scrape(url_path)
    bonappetit["ingredients"] = bonappetit["ingredients_raw"]
    bonappetit["ingredients"].each do |line|
      line.sub!(/\n/, " ")
      line.sub!(/\n/, " ")
    end
    bonappetit.delete("ingredients_raw")
    return bonappetit
  end
end
