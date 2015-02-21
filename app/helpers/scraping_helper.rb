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
    when "nytimes.com"
      load "scrapers/ny_cooking.rb"
      return NYCookingScraper.new.scrape(path)
    when "foodandwine.com"
      load "scrapers/food_and_wine.rb"
      return FoodWineScraper.new.scrape(path)
    when "bonappetit.com"
      load "scrapers/bon_appetit.rb"
      return BonAppetitScraper.new.scrape(path)
    when "allrecipes.com"
      load "scrapers/allrecipes.rb"
      return AllRecipesScraper.new.scrape(path)
    else
      return "unsupported"
    end
  end

  # Wombat returns arrays for ingredients and instructions.
  # These methods convert the arrays of strings into usable text.
  # The second method writes Markdown for the instructions.

  def write_ingredients_to_list(ingredients)
    ingredients_list = ""
    ingredients.each do |ingredient|
      # Add ingredient to the next line of ingredients_list
      ingredients_list << ingredient.to_s + "\n"
    end
    return ingredients_list
  end

  def form_markdown_for_instructions(steps)
    instructions_md = ""
    # each_with_index produces the step number
    steps.each_with_index do |step, id|
      # Arrays start at 0
      instructions_md << (id + 1).to_s + ". " + step + "\n"
    end
    return instructions_md
  end
end
