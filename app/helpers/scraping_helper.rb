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
    when 'nytimes.com'
      load 'scrapers/ny_cooking.rb'
      NYCookingScraper.new.scrape(path)
    when 'bonappetit.com'
      load 'scrapers/bon_appetit.rb'
      BonAppetitScraper.new.scrape(path)
    when 'allrecipes.com'
      load 'scrapers/allrecipes.rb'
      AllRecipesScraper.new.scrape(path)
    when 'marthastewart.com'
      load 'scrapers/marthastewart.rb'
      MarthaStewartScraper.new.scrape(path)
    when 'food52.com'
      load 'scrapers/food52.rb'
      Food52Scraper.new.scrape(path)
    else
      page = open(url).read
      data = Hangry.parse page
      if data.name.to_s.length > 2
        # Crappy hack for Food & Wine b/c they use the name itemprop in the wong places
        data.name = Nokogiri::HTML::DocumentFragment.parse(page).css('[itemprop=name]')[2].text.strip if host == 'foodandwine.com'
        if host == 'epicurious.com'
          d = Nokogiri::HTML::DocumentFragment.parse(page).css('[itemprop=description] .truncatedTextModuleText')[0]
          data.description = d.blank? ? '' : d.text.strip
          data.instructions = Nokogiri::HTML::DocumentFragment.parse(page).css('[itemprop=recipeInstructions] > p:not(#chefNotes)').text.strip
        end
        # Support sites (mainly blogs) that use recipeInstructions oddly
        if data.instructions.match(/\n/).blank?
          data.instructions = []
          Nokogiri::HTML::DocumentFragment.parse(page).css('[itemprop=recipeInstructions]').each do |s|
            data.instructions.push(s.text.to_s.strip)
          end
        end
        recipe = {}
        recipe['title'] = data.name
        recipe['description'] = data.description
        recipe['ingredients'] = data.ingredients
        recipe['instructions'] = data.instructions
        recipe['serves'] = data.yield.to_s.squish.capitalize
        recipe
      else
        false
      end
    end
  end

  def create_recipe(recipe_data, url_source, flash_text)
    recipe = Recipe.new do |r|
      r.user_id = current_user.id
      r.title = recipe_data['title']
      r.description = recipe_data['description'].to_s.squish
      r.ingredients = write_ingredients_to_list(recipe_data['ingredients']).to_s
      r.instructions = form_markdown_for_instructions(recipe_data['instructions']).to_s
      r.source = url_source
      r.author = recipe_data['author'].to_s.squish
      r.serves = recipe_data['serves'].to_s.squish
      r.notes = recipe_data['notes'].to_s.squish
      r.favorite = false
      r.shared = false
      r.save
    end
    recipe.save
    if request.xhr?
      render text: recipe.id
    else
      flash[:green] = flash_text
      redirect_to recipe
    end
  end

  # Wombat returns arrays for ingredients and instructions, but Hangry returns strings.
  # These methods do a ton of cleanup on the text, normalizing it and removing weirdness.
  # They also convert the arrays and strings into actual text.
  # The instructions method then writes numbered list Markdown.

  def write_ingredients_to_list(ingredients)
    return if ingredients.blank?
    ingredients_list = ''
    ingredients.each do |item|
      ingredients_list += "#{item.to_s.squish.capitalize}\n"
    end
    ingredients_list.to_s.strip
  end

  def form_markdown_for_instructions(instructions)
    return if instructions.blank?
    steps = instructions
    if instructions.is_a? String
      # Remove newlines in the middle
      steps = steps.to_s.match(/\r\n/) ? steps.gsub!(/\r\n/, ' ') : steps
      # Split into array
      steps = steps.to_s.match(/\s\s+/) ? steps.split(/\s\s+/) : [].push(steps)
    else
      steps = instructions
    end
    # Remove crap "steps"
    steps.delete_if { |step| step.to_s.strip.gsub(/\s\s/, ' ').length < 3 || step.match('Preparation') }
    # Remove custom numbering
    steps.each { |step| step.gsub! /^\w?\d\.?/, '' }
    instructions_md = ''
    steps.each_with_index do |step, id|
      instructions_md += "#{(id + 1).to_s}. #{step.to_s.squish}\n"
    end
    instructions_md.to_s.strip
  end
end
