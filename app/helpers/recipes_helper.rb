module RecipesHelper
  include ApplicationHelper
  include TextHelper

  def sample_recipe
    Recipe.find_by_shared_id 'sample'
  end

  def recipe_embed(r = @recipe)
    ph = content_tag(:a, "#{r.title} on Noodles", href: share_url(r.shared_id))
    content_tag(:section, ph, id: "noodles-#{r.shared_id}") + embed_script(r)
  end

  def embed_script(recipe = @recipe)
    content_tag(:script, '', src: "#{embed_url(recipe.shared_id)}.js").html_safe
  end

  def embed_code(recipe = @recipe)
    "document.getElementById('noodles-#{recipe.shared_id}').innerHTML = '#{embed_html(recipe)}';"
  end

  def embed_html(recipe = @recipe)
    html = ApplicationController.new.render_to_string('recipes/embed', locals: { r: recipe }, layout: false)
    strip_whitespace(html)
  end

  def from_web?(source_data)
    source_data.to_s.match(/https?/).present?
  end

  def ingredient_processed(text, options = {})
    line = Nokogiri::HTML::DocumentFragment.parse(markdown(line))
    line = line.first_element_child

    name = options[:name] || (text.match(/# /) ? 'h1' : 'li')
    line.name = name

    options.delete 'name'
    # line['itemprop'] = 'recipeIngredient'
    options.each { |key, val| line[key] = val }

    line.to_s.html_safe
  end

  def instructions_processed(instructions = @recipe.instructions, options = {})
    text = markdown(instructions)
    # text = Nokogiri::HTML::DocumentFragment.parse(text)
    # text.css('li').each { |item| item['itemprop'] = 'instruction' }
    text.to_s.html_safe
  end

  def no_details?(recipe = @recipe)
    @recipe.slice(:source, :author, :serves).values.join.blank?
  end

  def details?(recipe = @recipe)
    !no_details?(recipe)
  end

  def notes_blankslate
    content_tag(:p, 'No notes for this recipe yet.', class: 'grey-3')
  end

  def notes_rendered(recipe = @recipe)
    recipe.notes.blank? ? notes_blankslate : markdown(recipe.notes)
  end
end
