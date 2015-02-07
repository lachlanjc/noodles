require "wombat"

class FoodWineScraper
  include Wombat::Crawler

  def scrape(url_path)
    return Wombat.crawl do
      base_url "http://foodandwine.com"
      path url_path

      title css: ".recipe-title h1"
      description css: ".recipe-dek .dek"
      ingredients({ css: "#ingredients li" }, :list)
      instructions({ css: "#directions ol li" }, :list)
      # source css: ".instructions #additional-info .recipe-source-info"
    end
  end
end
