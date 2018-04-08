module RecipesHelper
  include ApplicationHelper
  include TextHelper

  def sample_recipe
    Recipe.find_by shared_id: 'sample'
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

  def recipe_ingredients(r = @recipe, options = {})
    content_tag :ul, r.ingredients.lines.map { |a| ingredient_processed(a, options) }.join.html_safe
  end

  def ingredient_processed(line, options = {})
    text = markdown(line)
    node = Nokogiri::HTML::DocumentFragment.parse(text).first_element_child
    return text.to_s.html_safe if node.blank?

    node.name = line.match?('# ') ? 'h1' : 'li'

    options.delete :name
    options.each { |key, val| node[key] = val } # For data-behavior (Cook Mode)

    if !text.match?('# ') && text.match(/\d/)
      begin
        i = Ingreedy.parse(node.children.to_s).ingredient
        c = node.children.to_s
        node.children = c.gsub(i, "<u>#{i}</u>")
      rescue Ingreedy::ParseFailed
      end
    end

    node.to_s.html_safe
  end

  def instructions_processed(instructions = @recipe.instructions, _options = {})
    markdown(instructions).to_s.html_safe
    # text = Nokogiri::HTML::DocumentFragment.parse(text)
    # text.css('li').each { |item| item['itemprop'] = 'instruction' }
  end

  def no_details?(_recipe = @recipe)
    @recipe.slice(:source, :author, :serves).values.join.blank?
  end

  def details?(recipe = @recipe)
    !no_details?(recipe)
  end

  def notes_blankslate
    content_tag :p, 'No notes for this recipe yet.', class: 'grey-3'
  end

  def notes_rendered(recipe = @recipe)
    recipe.notes.blank? ? notes_blankslate : markdown(recipe.notes)
  end

  def composer_for(model, field)
    react_component 'Composer',
                    name: "#{model}[#{field}]",
                    id: [model, field].join('_')
  end
end
