class AnalyticsController < ApplicationController
  def check_access(id)
    if id == 1 or id == 2
      @access = true
      @users = User.all.reverse
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

  def marketable
    authenticate
  end

  def all_users
    authenticate
  end
end
