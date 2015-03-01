require "wombat"

module SaveHelper
  include ScrapingHelper

  def scrape_for_schema_data(url)
    url_host = "http://" + find_host(url)
    url_path = find_path(url)

    return Wombat.crawl do
      base_url url_host
      path url_path

      title css: "*[itemprop='name']:first-child"
      description css: "*[itemprop='description']"
      ingredients({ css: "*[itemprop='ingredients']" }, :list)
      instructions({ css: "*[itemprop='recipeInstructions'] *" }, :list)

      serves css: "*[itemprop='recipeYield']"
    end
  end
end
