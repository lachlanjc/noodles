module AnalyticsHelper
  def user_recipes_count(user = current_user)
    user.recipes.count
  end

  def user_collections_count(user = current_user)
    user.collections.count
  end
end
