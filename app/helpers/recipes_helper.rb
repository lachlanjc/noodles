module RecipesHelper
  def me_owns_recipe?
    if current_user && @recipe.user_id == current_user.id
      return true
    else
      return false
    end
  end

  def recipe_shared?
    case @recipe.shared
    when true then true
    else false
    end
  end
end
