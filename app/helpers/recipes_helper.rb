module RecipesHelper
  include MarkdownHelper

  end

  def me_owns_recipe?
    if current_user && @recipe.user_id == current_user.id
      return true
    else
      return false
    end
  end

  def shared_url(recipe)
    "#{root_url}s/#{recipe.shared_id.to_s}"
  end

  def generate_shared_id(id)
    hashids = Hashids.new "113011262014"
    return hashids.encode(id * 11262014)
  end

  def is_from_web(source_data)
    /(http)/.match(source_data.to_s).to_s == "http"
  end
end
