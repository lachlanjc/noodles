class AnalyticsController < ApplicationController
  before_filter :authenticate

  def authenticate
    if current_user && (current_user.id == 1 || current_user.id == 23)
      @access = true
    else
      @access = false
      flash[:danger] = "Sorry, you can't look at that page."
      redirect_to root_url
    end
  end

  def recipes
    if @access == true
      @recipes = Recipe.all.order(created_at: :desc)
    end
  end

  def all_users
    if @access == true
      @users = User.all.order(created_at: :desc)
    end
  end

  def marketable
    if @access == true
      @users = User.all.order(created_at: :desc)
    end
  end
end
