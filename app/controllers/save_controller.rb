class SaveController < ApplicationController
  include ApplicationHelper
  include ScrapingHelper

  before_filter :validate_url
  before_filter :redirect_guests

  def save
    recipe_data = master_scrape(params[:url])
    if recipe_data == false || recipe_data['title'].blank?
      flash[:red] = 'Sorry — that site isn\'t working because it doesn\'t use standard markup for the recipe.'
      go_back
    else
      create_recipe(recipe_data, params[:url], "Awesome! We've saved #{recipe_data['title']} from #{find_domain(params[:url]).to_s.humanize}.")
    end
  end

  protected

  def url_is_valid?(u = params[:url])
    url = URI.parse(u) rescue false
    url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
  end

  def validate_url
    unless url_is_valid?
      flash[:red] = 'You didn\'t provide a valid recipe link.'
      go_back
    end
  end

  def redirect_guests
    return if user_signed_in?
    flash[:blue] = 'Hey there! Sign up for Noodles (below) to save that awesome recipe.'
    redirect_to root_url
  end
end
