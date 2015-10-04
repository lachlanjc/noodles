class SaveController < ApplicationController
  include ApplicationHelper
  include ScrapingHelper

  before_filter :validate_url

  def save
    if user_signed_in?
      recipe_data = master_scrape(params[:url])
      if recipe_data == false || recipe_data['title'].blank?
        flash[:red] = 'Sorry — that site isn\'t working because it doesn\'t use standard markup for the recipe.'
        go_back
      else
        create_recipe(recipe_data, params[:url], "Awesome! We've saved #{recipe_data['title']} from #{find_host(params[:url]).to_s.humanize}.")
      end
    else
      flash[:blue] = 'Hey there! Sign up for Noodles below to save that awesome recipe.'
      redirect_to root_url
    end
  end

  protected

  def url_is_valid?(u = params[:url])
    url = URI.parse(u) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end

  def validate_url
    valid = url_is_valid?
    render text: 'You didn\'t provide a valid recipe link.', status: 422 unless valid
  end
end
