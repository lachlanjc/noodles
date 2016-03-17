class CookController < ApplicationController
  include RecipesHelper

  def index
    @recipe = Recipe.find(params[:id])
    raise_not_found

    if me_owns_recipe?
      render :index
    else
      flash[:red] = "You can't cook recipes that aren't yours!"
      redirect_to root_url
    end
  end

  def share
    @recipe = Recipe.find_by_shared_id(params[:shared_id])
    raise_not_found
    render :index
  end

  private

  def raise_not_found
    raise ActiveRecord::RecordNotFound if @recipe.nil?
  end
end
