require 'wombat'

class MarthaStewartScraper
  include Wombat::Crawler

  def scrape(url_path)
    Wombat.crawl do
      base_url 'http://marthastewart.com'
      path url_path

      title css: 'h1[itemprop=name]'
      description css: 'h4.top-intro-dek[itemprop=page-dek]'
      ingredients({ css: '.components-group .components-list li' }, :list)
      instructions({ css: '.recipe-unit-title + ol .recipe-step-item' }, :list)
    end
  end
end
