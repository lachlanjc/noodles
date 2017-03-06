class SaveController < ApplicationController
  include ApplicationHelper
  include ScrapingHelper

  before_action :validate_url
  before_action :redirect_guests

  def save
    recipe_data = master_scrape(params[:url])
    if recipe_data.nil? || recipe_data[:title].blank?
      EmailMeJob.perform_later(subject: 'Escargot issue', body: params[:url])
      action_unsupported!
    else
      action_save!(recipe_data)
    end
  end

  private

  def url_is_valid?(u = params[:url])
    url = URI.parse(u) rescue false
    url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
  end

  def validate_url
    unless url_is_valid?
      flash[:danger] = 'That isn’t a valid URL.'
      go_back
    end
  end

  def redirect_guests
    return if user_signed_in?
    flash[:notice] = 'Sign up or sign in to save that recipe.'
    redirect_to new_user_registration_url
  end

  def action_unsupported!
    flash_or_text :danger, 'Noodles can’t clip that now—but the developer has been notified.'
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
