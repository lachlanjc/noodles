module AnalyticsHelper
  include ApplicationHelper

  def user_recipes_count(user = current_user)
    user.recipes.count
  end

  def heap_recipe_analytics
    "'recipes_count': #{user_recipes_count}," if simple_controller == 'recipes'
  end

  def user_collections_count(user = current_user)
    user.collections.count
  end

  def heap_coll_analytics
    "'collections_count': #{user_collections_count}," if simple_controller == 'collections'
  end

  def intercom_custom_data
    data = {}
    if simple_controller == 'devise/registrations'
      data[:referring_url] = current_user.referring_url
      data[:landing_url] = current_user.landing_url
    end
    data[:recipes_count] = user_recipes_count if simple_controller == 'recipes'
    data[:collections_count] = user_collections_count if simple_controller == 'collections'
    data
  end
end
