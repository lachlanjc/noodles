# Provide all services related to scraping the web for a recipe.
module ScrapingHelper
  include RecipesHelper

  def master_scrape(link)
    host = find_domain(link)
    path = find_path(link)

    url = link
    url.gsub!(/\/print/, '') if host =~ /allrecipes\.com/

    page = safely { open(url).read }
    data = Hangry.parse page
    # Allrecipes has trouble with names
    if data.name.to_s.squish.length > 1 || host =~ /allrecipes\.com/
      data = process_recipe_page(url, page, data)
    else
      false
    end
  end

  # Process recipe pages
  def process_recipe_page(url, page, data)
    host = find_domain(url).to_s
    document = Nokogiri::HTML::DocumentFragment.parse(page)
    if host =~ /nytimes\.com/
      data = process_nyt_page!(data, document)
    elsif host =~ /epicurious\.com/
      data = process_epicurious_page!(data, document)
    # F&W/AR use the name itemprop in the wrong places
    elsif host =~ /allrecipes\.com/
      data.name = document.css('[itemprop=name]')[0].attr('content').to_s
    elsif host =~ /foodandwine\.com/
      data.name = document.css('[itemprop=name]')[2].text.to_s.squish
    elsif host =~ /bonappetit\.com/
      data = process_ba_page!(data, document)
    elsif host =~ /marthastewart\.com/
      data.instructions = document.css('.directions-list .directions-item').text
    elsif host =~ /driscolls\.com/
      data.instructions = document.css('#recipe-content #instructions').text
    elsif data.instructions.to_s.match(/\n/).blank?
      data = process_blog_page!(data, document)
    end
    recipe = create_recipe_item(data)
  end

  # Adjust for NYT Cooking pages
  def process_nyt_page!(data, document)
    data.ingredients = []
    document.search('.recipe-ingredients')[0].search('li').each do |it|
      v = it.text.squish.gsub(/:$/, '').capitalize
      v.prepend('# ') if it.search('.quantity').text.blank? && it.text =~ /For/
      data.ingredients.push v
    end
    data.instructions = []
    document.search('.recipe-steps li').each do |step|
      data.instructions.push step.text.squish
    end
    data.instructions = document.search('.recipe-steps').text
    data.author = document.search('.recipe-subhead span[itemprop=author]').text
    data
  end

  # Clean up inconsistencies in Epicurious pages
  def process_epicurious_page!(data, document)
    d = document.css('[itemprop=description] .truncatedTextModuleText')[0]
    data.description = d.blank? ? '' : d.text.squish
    insts = document.css("#{inst} > p:not(#chefNotes)")
    insts = document.css("#{inst} li:not(#chefNotes)") if insts.empty?
    data.instructions = insts.text
    data
  end

  # Process Bon Appetit page
  def process_ba_page!(data, document)
    data.name = document.css('h1[itemprop=name]').text
    data.ingredients = []
    document.search('.ingredients li').each do |step|
      data.ingredients.push step.text.squish
    end
    data.instructions = document.css('.prep-steps li.step').text
    data.author = document.css('.contributors li')[0].text.strip
    data
  end

  # Support sites (mainly blogs) that use recipeInstructions oddly
  def process_blog_page!(data, document)
    data.instructions = []
    document.css(inst).each do |s|
      data.instructions.push(s.text.to_s.squish)
    end
    data
  end

  # Basic scaffolding for recipe item
  def create_recipe_item(data)
    {
      title: data.name.to_s.squish.truncate(255),
      description: data.description.to_s.squish,
      ingredients: data.ingredients,
      instructions: data.instructions,
      serves: data.yield.to_s.capitalize.gsub('Servings:', '').strip
    }
  end

  # Create a Recipe with provided data, and respond appropriately
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
    ingredients = write_ingredients_to_list(ingredients)
    ingredients
  end

  # Remove inconsistencies in ingredient formatting
  def clean_ingredients(ingredients)
    ingredients = ingredients.split(/\s\s+/) if ingredients.is_a? String
    ingredients.delete_if { |item| item.to_s.squish!.gsub(/\s\s+/, ' ').length < 3 }
    # Each of the steps is now in an array.
    ingredients.each do |item|
      # Remove custom lists or line breaks
      item.gsub!(/^\-|\*\s?/, '').to_s.gsub!(/\s\s+/, ' ').to_s.squish!.capitalize
    end
    ingredients
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
    steps.each do |step|
      # Remove custom numbering or line breaks
      step.gsub!(/^\w?\d\.?/, '').to_s.squish!
    end
    steps
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
