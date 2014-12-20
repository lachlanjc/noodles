module AnalyticsHelper
  def user_recipe_count(user)
    return Recipe.where(:user_id => user.id).count
  end

  def user_shared_recipe_count(user)
    return Recipe.where(:user_id => user.id, :shared => true).count
  end
end
