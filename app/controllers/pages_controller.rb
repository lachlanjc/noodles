class PagesController < ApplicationController
  def home
    expires_in 6.months, :public => true
    render :home, layout: false
  end

  def home_forced
    expires_in 2.months, :public => true
    render :home, layout: false
  end

  def about
  end

  def styleguide
  end
end
