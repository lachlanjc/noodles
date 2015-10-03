module AnalyticsHelper
  def user_recipe_count(user)
    Recipe.where(:user_id => user.id).count
  end

  def user_shared_recipe_count(user)
    Recipe.where(:user_id => user.id, :shared => true).count
  end

  def user_collection_count(user = current_user)
    user.collections.count
  end
end
