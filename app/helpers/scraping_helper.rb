module ScrapingHelper
  include RecipesHelper

  def find_host(url)
    URI(url).host.to_s
  end

  def find_domain(url)
    find_host(url).match(/[^\.]+\.\w+$/).to_s
  end

  def find_path(url)
    URI(url).path.to_s
  end

  def master_scrape(url)
    host = find_domain(url)
    path = find_path(url)

    case host
    when "epicurious.com"
      load "scrapers/epicurious.rb"
      EpicuriousScraper.new.scrape(path)
    when "nytimes.com"
      load "scrapers/ny_cooking.rb"
      NYCookingScraper.new.scrape(path)
    when "foodandwine.com"
      load "scrapers/food_and_wine.rb"
      FoodWineScraper.new.scrape(path)
    when "bonappetit.com"
      load "scrapers/bon_appetit.rb"
      BonAppetitScraper.new.scrape(path)
    when "allrecipes.com"
      load "scrapers/allrecipes.rb"
      AllRecipesScraper.new.scrape(path)
    when "kingarthurflour.com"
      load "scrapers/kingarthurflour.rb"
      KingArthurFlourScraper.new.scrape(path)
    when "marthastewart.com"
      load "scrapers/marthastewart.rb"
      MarthaStewartScraper.new.scrape(path)
    when "food52.com"
      load "scrapers/food52.rb"
      Food52Scraper.new.scrape(path)
    else
      false
    end
  end

  def create_recipe(recipe_data, url_source, flash_text)
    if !recipe_data["has_ingredients_sets"]
      processed_ingredients = write_ingredients_with_sets(recipe_data["ingredient_sets"])
    else
      processed_ingredients = write_ingredients_to_list(recipe_data["ingredients"])
    end

    recipe = Recipe.new do |r|
      r.user_id = current_user.id
      r.title = recipe_data["title"]
      r.description = recipe_data["description"].to_s.squish
      r.ingredients = processed_ingredients.to_s
      r.instructions = form_markdown_for_instructions(recipe_data["instructions"])
      r.source = url_source
      r.serves = recipe_data["serves"].to_s
      r.notes = recipe_data["notes"].to_s
      r.favorite, r.shared = false
      r.save
    end
    recipe.shared_id = generate_shared_id(recipe.id)
    recipe.save
    flash[:success] = flash_text
    redirect_to recipe
  end

  def write_ingredients_with_sets(ingredient_sets)
    processed_ingredients = ""
    ingredient_sets.each do |set|
      processed_ingredients << "# #{set['header'].squish} \n" if set["header"].length > 1
      set["lines"].each do |line|
        processed_ingredients << line + "\n"
      end
    end
    processed_ingredients
  end

  def write_ingredients_to_list(ingredients)
    ingredients_list = ""
    return if ingredients.blank?
    ingredients.each do |ingredient|
      # Add ingredient (minus extra whitespace) to the next line of ingredients_list
      ingredients_list += "#{ingredient.to_s.squish} \n"
    end
    ingredients_list
  end

  def form_markdown_for_instructions(steps)
    instructions_md = ""
    # each_with_index produces the step number
    steps.each_with_index do |step, id|
      instructions_md += (id + 1).to_s + ". " + step.to_s.squish + "\n"
    end
    return instructions_md
  end
end
