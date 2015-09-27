class SaveController < ApplicationController
  include ScrapingHelper

  before_filter :validate_url

  def save
    if user_signed_in?
      recipe_data = master_scrape(params[:url])
      if recipe_data == 'unsupported'
        flash[:red] = 'Hey! We\'re really sorry, but that website isn\'t working because it doesn\'t use the standard markup for recipes.'
        redirect_to root_url
      else
        create_recipe(recipe_data, params[:url], "Awesome! We've saved #{recipe_data['title']} from #{find_host(params[:url]).to_s.humanize}.")
      end
    else
      flash[:blue] = 'Hey there! Sign up for Noodles below to save that awesome recipe.'
      redirect_to root_url
    end
  end

  protected
    def validate_url
      if params[:url] =~ /\A#{URI::regexp(['http', 'https'])}\z/
        true
      else
        render text: 'You didn\'t provide a valid recipe link.', status: 422
      end
    end
end
