module ScrapingHelper
  include RecipesHelper

  def find_host(url)
    return URI(url).host.to_s
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
    when "marthastewart.com"
      load "scrapers/marthastewart.rb"
      return MarthaStewartScraper.new.scrape(path)
    when "food52.com"
      load "scrapers/food52.rb"
      return Food52Scraper.new.scrape(path)
    else
      return "unsupported"
    end
  end

  def create_recipe(recipe_data, url_source, flash_text)
    recipe = Recipe.new do |r|
      r.user_id = current_user.id
      r.title = recipe_data["title"]
      r.description = recipe_data["description"].to_s.squish
      r.ingredients = write_ingredients_to_list(recipe_data["ingredients"])
      r.instructions = form_markdown_for_instructions(recipe_data["instructions"])
      r.source = url_source
      r.serves = recipe_data["serves"].to_s
      r.notes = recipe_data["notes"].to_s
      r.favorite = false
      r.shared = false
      r.save
    end
    recipe.shared_id = generate_shared_id(recipe.id)
    recipe.save
    flash[:success] = flash_text
    redirect_to recipe
  end

  # Wombat returns arrays for ingredients and instructions.
  # These methods convert the arrays of strings into usable text.
  # Specifically, the second method writes Markdown out of an array of instructions.

  def write_ingredients_to_list(ingredients)
    ingredients_list = ""
    ingredients.each do |ingredient|
      # Add ingredient (minus extra whitespace) to the next line of ingredients_list
      ingredients_list += ingredient.to_s.squish + "\n"
    end
    return ingredients_list
  end

  def form_markdown_for_instructions(steps)
    instructions_md = ""
    # each_with_index produces the step number
    steps.each_with_index do |step, id|
                        # Arrays start at 0
      instructions_md += (id + 1).to_s + ". " + step.to_s.squish + "\n"
    end
    return instructions_md
  end
end
