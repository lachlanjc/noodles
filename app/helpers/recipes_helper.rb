module RecipesHelper
  def me_owns_recipe?
    if current_user && @recipe.user_id == current_user.id
      return true
    else
      return false
    end
  end

  def shared_url(id)
    return 'http://app.getnoodl.es/' + id.to_s
  end

  def generate_private_id(id)
    hashids = Hashids.new '113011262014'
    return hashids.encode(id * 11262014)
  end
end
