require 'json'

# Provide all services related to scraping the web for a recipe.
module ScrapingHelper
  include RecipesHelper

  def master_scrape(url)
    host = find_domain(url)
    path = find_path(url)

  begin
    # safely silence: Mechanize::ResponseCodeError do
      content = Mechanize.new.get("https://util.getnoodl.es/api/scrape?url=#{url}").content
      recipe = JSON.parse content
    # end
  rescue
    page = Mechanize.new.get(url).content
    data = Hangry.parse page
    recipe = process_recipe_page(url, page, data)
  end

    return unless recipe&.dig('name')
    create_recipe_item recipe
  end

  # Process recipe pages
  def process_recipe_page(url, page, data)
    host = find_domain(url).to_s
    doc = Nokogiri::HTML::DocumentFragment.parse(page)
    if host.match? 'nytimes.com' || data.to_h.values.reject(&:blank?).empty?
      data = process_schema_for data, doc
    elsif data.instructions.to_s.match(/\n/).blank?
      data = process_blog_page! data, doc
    end
    data
  end

  def process_schema_for(data, doc)
    if meta = doc.css('script[type="application/ld+json"]').text.squish
      values = JSON.parse(meta)
      data.name = values['name']
      data.description = values['description']&.squish
      data.ingredients = values['recipeIngredient']
      data.instructions = values['recipeInstructions']&.map { |o| o['text'] }
      data.yield = values['recipeYield'].to_s.remove('Makes ')
      data.author = values['author']['name']
    end
    data
  end

   # Support some sites (mainly blogs)
   def process_blog_page!(data, doc)
    data.instructions = doc.css(inst).to_a.map(&:text)
    if !data&.ingredients
      s = '.wprm-recipe-ingredient-group li[itemprop=recipeIngredient]'
      data.ingredients = doc.css(s).to_a.map(&:text)
    end
    data
  end

  # Basic scaffolding for recipe item
  def create_recipe_item(data)
    {
      title: data['name'].to_s.squish.truncate(255),
      description: data['description'].to_s.squish,
      ingredients: data['ingredients'],
      instructions: data['instructions'],
      serves: data['yield'].to_s.capitalize.remove('Servings:',).strip
    }
  end

  # Create a Recipe with provided data
  def create_recipe(recipe_data, url_source)
    Recipe.create(
      user_id: current_user.id,
      title: recipe_data[:title],
      description: recipe_data[:description],
      ingredients: process_recipe_ingredients(recipe_data[:ingredients]),
      instructions: process_recipe_instructions(recipe_data[:instructions]),
      source: url_source,
      author: recipe_data[:author].to_s.squish,
      serves: recipe_data[:serves].to_s.squish,
      notes: recipe_data[:notes].to_s.squish,
      favorite: false
    )
  end

  # Fully process recipe ingredients
  def process_recipe_ingredients(ingredients)
    return if ingredients.blank?
    ingredients = clean_ingredients(ingredients)
    write_ingredients_to_list(ingredients)
  end

  # Remove inconsistencies in ingredient formatting
  def clean_ingredients(ingredients)
    ingredients = ingredients.split(/\s\s+/) if ingredients.is_a? String
    ingredients.delete_if { |item| item.to_s.squish!.gsub(/\s\s+/, ' ').length < 3 }
    # Each of the steps is now in an array.
    ingredients.map do |item|
      # Remove custom lists or line breaks
      item.gsub(/^\-|\*\s?/, '').to_s.gsub(/\s\s+/, ' ').to_s.squish.capitalize
    end
  end

  # Write a list of ingredients
  def write_ingredients_to_list(ingredients)
    ingredients_list = ''
    ingredients.each { |item| ingredients_list += "#{item}\n" }
    ingredients_list.strip
  end

  # Fully process recipe instructions
  def process_recipe_instructions(instructions)
    return '' if instructions.blank?
    steps = clean_instructions(instructions)
    steps = form_markdown_for_instructions(steps)
    steps.chomp
  end

  # Remove inconsistencies in instruction formatting
  def clean_instructions(steps)
    steps = steps.split(/[\n+]/) if steps.is_a?(String)
    # Each of the steps is now in an array.
    # Remove useless steps
    steps.delete_if do |step|
      step.to_s.squish.length < 3 || step.to_s.match('Preparation')
    end
    steps.map do |step|
      # Remove custom numbering or line breaks
      step.gsub(/^\w?\d\.?/, '').to_s.squish
    end
  end

  # Generate Markdown based on instructions
  def form_markdown_for_instructions(instructions)
    instructions_md = ''
    instructions.each_with_index do |step, id|
      instructions_md += "#{(id + 1)}. #{step.squish}\n"
    end
    instructions_md.strip
  end

  protected

  def inst
    '[itemprop=recipeInstructions]'
  end
  
  def find_domain(url)
    URI(url).host.to_s.match(/[^\.]+\.\w+$/).to_s
  end
  
  def find_domain_name(url)
    find_domain(url).match(/(.+)\.\w+/)[1].to_s
  end
  
  def find_path(url)
    URI(url).path.to_s
  end
end
