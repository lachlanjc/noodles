class RecipesController < ApplicationController

  before_filter :authenticate_user!, only: [:show, :new, :edit, :update, :destroy]

  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      flash[:success] = 'Great, your recipe has been successfully saved.'
      redirect_to @recipe
    else
      render :new
    end
  end

  # PATCH/PUT /recipes/1
  def update
    if @recipe.update(recipe_params)
      flash[:success] = 'Awesome, your changes have been saved.'
      redirect_to @recipe
    else
      render :edit
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
    flash[:danger] = 'Your recipe is no more.'
    redirect_to recipes_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recipe_params
      params.require(:recipe).permit(:title, :description, :ingredients, :instructions)
    end

end
