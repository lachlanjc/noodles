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

    case host
    when "epicurious.com"
      load "scrapers/epicurious.rb"
      return EpicuriousScraper.new.scrape(path)
    when "bonappetit.com"
      load "scrapers/bon_appetit.rb"
      return BonAppetitScraper.new.scrape_and_process(path)
    when "foodandwine.com"
      load "scrapers/food_and_wine.rb"
      return FoodWineScraper.new.scrape(path)
    when "nytimes.com"
      load "scrapers/ny_cooking.rb"
      return NYCookingScraper.new.scrape_and_process(path)
    when "allrecipes.com"
      load "scrapers/allrecipes.rb"
      return AllRecipesScraper.new.scrape(path)
    else
      return "unsupported"
    end
  end
end
