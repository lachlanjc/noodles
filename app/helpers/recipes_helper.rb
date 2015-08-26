module RecipesHelper
  include MarkdownHelper

  def me_owns_recipe?
    user_signed_in? && @recipe.user_id == current_user.id
  end

  def not_my_recipe?
    !me_owns_recipe?
  end

  def shared_url(recipe)
    "#{root_url}s/#{recipe.shared_id.to_s}"
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
end
