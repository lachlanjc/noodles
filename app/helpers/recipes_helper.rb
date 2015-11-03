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

  def from_web?(source_data)
    /(http)/.match(source_data.to_s).to_s == 'http'
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

  def no_details?(recipe = @recipe)
    recipe.source.blank? && recipe.author.blank? && recipe.serves.blank?
  end

  def details?(recipe = @recipe)
    !no_details?(recipe)
  end
end
