class SaveController < ApplicationController
  include ApplicationHelper
  include ScrapingHelper

  before_filter :validate_url
  before_filter :redirect_guests

  def save
    recipe_data = master_scrape(params[:url])
    if recipe_data.nil? || recipe_data[:title].blank?
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
      flash[:danger] = 'You didn\'t provide a valid recipe link.'
      go_back
    end
  end

  def redirect_guests
    return if user_signed_in?
    flash[:info] = 'Hey there! Sign up for Noodles to save that awesome recipe.'
    redirect_to new_user_registration_url
  end

  private

  def action_unsupported!
    msg = "Sorry — we can't clip from that site."
    flash_or_text(:danger, msg)
    go_back unless request.xhr?
  end

  def action_save!(recipe_data)
    @recipe = create_recipe(recipe_data, params[:url])
    dom = find_domain_name(params[:url]).humanize
    msg = "Saved #{@recipe.title} from #{dom}."
    flash_or_text(:success, @recipe.id, msg)
      redirect_to @recipe unless request.xhr?
  end
end
