class ExploreController < ApplicationController
  include ExploreHelper
  include RecipesHelper
  include ScrapingHelper

  def index
  end

  def results
    @results = find_explore_results(params[:src], params[:q])
    render :results, layout: false
  end

  def preview
    recipe_data = master_scrape(params[:url])
    @recipe = prepare_explore_preview(recipe_data)
    render :preview, layout: false
  end

  def clip
    recipe_data = master_scrape(params[:url])

    if recipe_data == "unsupported"
      flash[:red] = "Sorry, we don't support that site yet."
      redirect_to recipes_path
    else
      create_recipe(recipe_data, params[:url], "Recipe imported!")
    end
  end
end
