class ExploreController < ApplicationController
  include ApplicationHelper
  include ExploreHelper
  include MarkdownHelper
  include RecipesHelper
  include ScrapingHelper

  before_filter :please_sign_in, only: [:index]

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

end
