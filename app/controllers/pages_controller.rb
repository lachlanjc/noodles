class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to recipes_path
    else
      expires_in 6.months, :public => true
      render :home, layout: false
    end
  end

  def home_forced
    expires_in 2.months, :public => true
    render :home, layout: false
  end

  def about
  end
end
