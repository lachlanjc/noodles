class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  def index
    if current_user
      @recipes = Recipe.where(:user_id => current_user.id)
    else
      render "home"
    end
  end

  # GET /recipes/1
  def show
    if @recipe.user_id == current_user.id
      set_recipe
    else
      flash[:error] = "You are not allowed to look at that recipe."
      redirect_to root_url
    end
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    if @recipe.user_id == current_user.id
      set_recipe
    else
      flash[:error] = "Whoops! That recipe isn't yours."
      redirect_to root_url
    end
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    if @recipe.save
      flash[:success] = "Your recipe has been created."
      redirect_to @recipe
    else
      render :new
    end
  end

  # PATCH/PUT /recipes/1
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Awesome, your changes have been saved."
      redirect_to @recipe
    else
      render :edit
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
    flash[:alert] = "Your recipe has been deleted."
    redirect_to recipes_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow trusted parameters
    def recipe_params
      params.require(:recipe).permit(:title, :description, :ingredients, :instructions)
    end
end
