class CookController < ApplicationController
  include ApplicationHelper
  include RecipesHelper

  def index
    @recipe = Recipe.find(params[:recipe_id])

    if me_owns_recipe? || @recipe.shared?
      @recipe_step_count = @recipe.instructions.lines.count
      if me_owns_recipe?
        @exit_link = recipe_path(@recipe.id)
      else
        @exit_link = share_path(@recipe.shared_id)
      end
      render :index
    else
      flash[:red] = "You can't cook with recipes that aren't yours!"
      redirect_to root_url
    end
  end
end
