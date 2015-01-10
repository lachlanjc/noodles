require 'wombat'

class NYCookingScraper
  include Wombat::Crawler

  def scrape(url_path)
    return Wombat.crawl do
      base_url "http://cooking.nytimes.com"
      path url_path

      title css: ".recipe-title"
      ingredients_raw({ css: ".recipe-ingredients li" }, :list)
      instructions({ css: ".recipe-steps li" }, :list)
      serves css: ".recipe-time-yield span[itemprop=\"recipeYield\"]"

      notes css: ".recipe-note-description"
    end
  end

  def scrape_and_process(url_path)
    nyt = scrape(url_path)
    nyt["ingredients"] = nyt["ingredients_raw"]
    nyt["ingredients"].each do |line|
      3.times do
        line.sub!(/\n/, " ")
      end
    end
    nyt.delete("ingredients_raw")
    return nyt
  end
end
