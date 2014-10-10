class AnalyticsController < ApplicationController
  def check_access(id)
    if id == 1 or id == 4
      @access = true
    else
      @access = false
    end
  end

  def authenticate
    if current_user
      check_access(current_user.id)
    else
      flash[:error] = "Sorry, you can't look at that page."
      redirect_to root_url
    end
  end

  def recipes
    authenticate
    @recipes = Recipe.all.reverse
  end

  def all_users
    authenticate
    @users = User.all.reverse
  end

  def marketable
    authenticate
    @users = User.all.reverse
  end
end
