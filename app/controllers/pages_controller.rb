class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to recipes_path
    else
      render :home, layout: false
    end
  end

  def home_forced
    render :home, layout: false
  end

  def about
  end
end
