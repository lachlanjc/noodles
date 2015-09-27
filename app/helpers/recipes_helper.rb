module RecipesHelper
  include ApplicationHelper
  include MarkdownHelper

  def me_owns_recipe?
    user_signed_in? && @recipe.user_id == current_user.id
  end

  def not_my_recipe?
    !me_owns_recipe?
  end

  def shared_path(recipe = @recipe)
    "/s/#{recipe.shared_id.to_s}"
  end

  def shared_url(recipe = @recipe)
    app_url + shared_path(recipe)
  end

  def generate_shared_id(id)
    hashids = Hashids.new "113011262014"
    hashids.encode(id.to_i * 11262014)
  end

  def is_from_web(source_data)
    /(http)/.match(source_data.to_s).to_s == "http"
  end

  def ingredient_processed(text)
    line = sanitize markdown(text)
    line = Nokogiri::HTML::DocumentFragment.parse(line)
    line.css('p').each { |item| item['itemprop'] = 'recipeIngredient' }
    line.to_s.html_safe
  end

  def instructions_processed(instructions = @recipe.instructions)
    text = sanitize markdown(instructions)
    text = Nokogiri::HTML::DocumentFragment.parse(text)
    text.css('li').each { |item| item['itemprop'] = 'instruction' }
    text.to_s.html_safe
  end

  def plain_text_from_markdown(text)
    sanitize(strip_tags(markdown(text.to_s)))
  end
end
