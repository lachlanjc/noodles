module AnalyticsHelper
  def user_recipe_count(user = current_user)
    user.recipes.count
  end

  def user_shared_recipe_count(user = current_user)
    user.recipes.where(shared: true).count
  end

  def user_collection_count(user = current_user)
    user.collections.count
  end
end
