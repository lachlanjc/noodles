class CookController < ApplicationController
  include ApplicationHelper
  include RecipesHelper

  def index
    @recipe = Recipe.find(params[:recipe_id])

    if me_owns_recipe?
      render :index
    else
      flash[:red] = "You can't cook with recipes that aren't yours!"
      redirect_to root_url
    end
  end

  def share
    @recipe = Recipe.find_by_shared_id(params[:shared_id])
    render :index
  end
end
