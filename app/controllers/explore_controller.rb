class ExploreController < ApplicationController
  include ExploreHelper
  include ScrapingHelper

  def index; end

  def results
    @results = find_explore_results(params[:src], params[:q])
    render :results, layout: false
  end

  def preview
    recipe_data = master_scrape(params[:url])
    @recipe = prepare_explore_preview(recipe_data)
    render :preview, layout: false
  end
end
