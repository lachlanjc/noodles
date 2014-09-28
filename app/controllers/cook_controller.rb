class CookController < ApplicationController
  def index
    @recipe = Recipe.find(params[:recipe_id])

    if @recipe.user_id == current_user.id
      set_recipe
    else
      flash[:view] = "No cooking with recipes that aren't yours!"
      redirect_to root_url
    end
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:recipe_id])
    end
end
