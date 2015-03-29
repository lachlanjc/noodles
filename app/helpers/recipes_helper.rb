module RecipesHelper
  include MarkdownHelper

  def me_owns_recipe?
    if current_user && @recipe.user_id == current_user.id
      return true
    else
      return false
    end
  end

  def shared_url(shared_id)
    return "http://www.getnoodl.es/s/#{shared_id}"
  end

  def generate_shared_id(id)
    hashids = Hashids.new "113011262014"
    return hashids.encode(id * 11262014)
  end

  def is_from_web(source_data)
    case /(http)/.match(source_data.to_s).to_s
    when "http" then true
    else false
    end
  end
end
