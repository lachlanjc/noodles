module ScrapingHelper
  def find_host(url)
    return URI(url).host.to_s.match(/[^\.]+\.\w+$/).to_s
  end

  def find_path(url)
    return URI(url).path.to_s
  end

  def master_scrape(url)
    host = find_host(url)
    path = find_path(url)

    if host == 'epicurious.com'
      load 'scrapers/epicurious.rb'
      content = EpicuriousScraper.new.scrape(path)
      return content
    elsif host == 'bonappetit.com'
      load 'scrapers/bon_appetit.rb'
      content = BonAppetitScraper.new.scrape_and_process(path)
      return content
    elsif host == 'foodandwine.com'
      load 'scrapers/food_and_wine.rb'
      content = FoodWineScraper.new.scrape(path)
      return content
    elsif host == 'nytimes.com'
      load 'scrapers/ny_cooking.rb'
      content = NYCookingScraper.new.scrape_and_process(path)
      return content
    elsif host == 'allrecipes.com'
      load 'scrapers/allrecipes.rb'
      content = AllRecipesScraper.new.scrape_and_process(path)
      return content
    else
      return 'unsupported'
    end
  end
end
