class PagesController < ApplicationController
  def home
    render :home, layout: false
  end

  def home_forced
    render :home, layout: false
  end

  def about
  end

  def styleguide
  end
end
