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
    when "nytimes.com"
      load "scrapers/ny_cooking.rb"
      NYCookingScraper.new.scrape(path)
    when "bonappetit.com"
      load "scrapers/bon_appetit.rb"
      BonAppetitScraper.new.scrape(path)
    when "allrecipes.com"
      load "scrapers/allrecipes.rb"
      AllRecipesScraper.new.scrape(path)
    when "marthastewart.com"
      load "scrapers/marthastewart.rb"
      MarthaStewartScraper.new.scrape(path)
    when "food52.com"
      load "scrapers/food52.rb"
      Food52Scraper.new.scrape(path)
    else
      page = open(url).read
      data = Hangry.parse page
      if data.name.to_s.length > 2
        # Crappy hack for Food & Wine b/c they use the name itemprop in the wong places
        data.name = Nokogiri::HTML::DocumentFragment.parse(page).css('[itemprop=name]')[2].text.strip if host == 'foodandwine.com'
        recipe = {}
        recipe['title'], recipe['description'] = data.name, data.description
        recipe['ingredients'], recipe['instructions'] = data.ingredients, data.instructions
        recipe['serves'] = data.yield.to_s.squish.capitalize
        recipe
      else
        'unsupported'
      end
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
      r.author = recipe_data["author"].to_s.squish
      r.serves = recipe_data["serves"].to_s.squish
      r.notes = recipe_data["notes"].to_s.squish
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
    return if ingredients.blank?
    ingredients_list = ""
    ingredients.each do |item|
      ingredients_list += item.to_s.squish + "\n"
    end
    ingredients_list
  end

  def form_markdown_for_instructions(instructions)
    return if instructions.blank?
    instructions_md = ""
    if instructions.is_a?(String)
      steps = instructions.split(/\s\s+/)
      steps.delete_if { |step| step.to_s.strip.length < 2 }
    else
      steps = instructions
    end
    steps.each_with_index do |step, id|
      instructions_md += "#{(id + 1).to_s}. #{step.to_s.squish}\n"
    end
    instructions_md
  end
end
