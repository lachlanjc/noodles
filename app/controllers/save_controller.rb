class SaveController < ApplicationController
  include SaveHelper

  def save
    if params[:url] && params[:url].length > 10
      if user_signed_in?
        recipe_data = scrape_for_schema_data(params[:url])
        recipe_data["source"] = params[:url]
        if recipe_data["title"].blank? && recipe_data["ingredients"].blank?
          # If we're not getting anything, we need to say sorry
          flash[:red] = "Sorry, that website hasn't implemented the schema.org tags correctly."
          redirect_to recipes_path
        end
        create_recipe(recipe_data, params[:url], "We've saved #{recipe_data['title']} from #{find_host(params[:url])}.")
      else
        flash[:blue] = "Hey, you'll need an account on Noodles first :)"
        redirect_to root_url
      end
    else
      render text: "Hmm, you didn't provide the recipe link."
    end
  end
end
