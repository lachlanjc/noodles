class AnalyticsController < ApplicationController
  def check_access(id)
    if id == 1 or id == 23
      @access = true
    else
      @access = false
    end
  end

  def authenticate
    if current_user
      check_access(current_user.id)
    else
      flash[:danger] = "Sorry, you can't look at that page."
      redirect_to root_url
    end
  end

  def recipes
    authenticate
    if @access == true
      @recipes = Recipe.all.order(created_at: :desc)
    else
      flash[:danger] = "You're not allowed to see those."
      redirect_to root_url
    end
  end

  def all_users
    authenticate
    if @access == true
      @users = User.all.order(created_at: :desc)
    else
      flash[:danger] = "You're not allowed to see those."
      redirect_to root_url
    end
  end

  def marketable
    authenticate
    if @access == true
      @users = User.all.order(created_at: :desc)
    else
      flash[:danger] = "You're not allowed to see those."
      redirect_to root_url
    end
  end
end
