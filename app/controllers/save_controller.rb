class SaveController < ApplicationController
  include ApplicationHelper
  include ScrapingHelper

  before_filter :validate_url
  before_filter :redirect_guests

  def save
    recipe_data = master_scrape(params[:url])
    if recipe_data == false || recipe_data[:title].blank?
      action_unsupported!
    else
      action_save!(recipe_data)
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

  private

  def action_unsupported!
    msg = "Sorry — that site isn't working because it doesn't use standard markup for the recipe."
    flash_or_text(:red, msg)
    go_back unless request.xhr?
  end

  def action_save!(recipe_data)
    @recipe = create_recipe(recipe_data, params[:url])
    dom = find_domain_name(params[:url]).humanize
    msg = "Awesome! You've saved #{@recipe.title} from #{dom}."
    flash_or_text(:green, @recipe.id, msg)
    redirect_to @recipe unless request.xhr?
  end
end
