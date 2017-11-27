class SaveController < ApplicationController
  include ApplicationHelper
  include ScrapingHelper

  before_action :validate_url
  before_action :please_sign_in

  def save
    if params[:url].match? 'getnoodl.es/s/'
      id = URI(params[:url]).path.gsub('/s/', '')
      if @recipe = Recipe.find_by(shared_id: id)
        @recipe.duplicate_for(current_user)
        action_supported 'Saved to your library.'
      else
        action_unsupported
      end
    else
      recipe_data = master_scrape(params[:url])
      if recipe_data.blank? || recipe_data[:title].blank?
        EmailMeJob.perform_later(subject: 'Escargot issue', body: params[:url])
        action_unsupported
      else
        action_supported save_data!(recipe_data)
      end
    end
  end

  private

  def url_is_valid?(u = params[:url])
    url = begin
            URI.parse(u)
          rescue
            false
          end
    url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
  end

  def validate_url
    unless url_is_valid?
      flash[:danger] = 'That isn’t a valid URL.'
      go_back
    end
  end

  def action_unsupported
    flash_or_text :danger, 'Noodles can’t import that now—but the developer has been notified.'
    go_back unless request.xhr?
  end

  def save_data!(recipe_data)
    @recipe = create_recipe(recipe_data, params[:url])
    dom = find_domain_name(params[:url]).humanize
    "Saved #{@recipe.title} from #{dom}."
  end

  def action_supported(msg)
    flash_or_text(:success, @recipe.id, msg)
    redirect_to @recipe
  end
end
