class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  def index
    @recipes = Recipe.accessible_by(current_ability, params[:update].to_sym)
  end

  # GET /recipes/1
  def show
    @recipe = Recipe.find(params[:id])
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
    @recipe.user = current_user

    # authorize! :create, @recipe

    if @recipe.save
      flash[:success] = "Your recipe has been created."
      redirect_to @recipe
    else
      render :new
    end
  end

  # PATCH/PUT /recipes/1
  def update
    @recipe = Recipe.find(params[:id])
    @recipe.assign_attributes(task_params)
    authorize! :update, @recipe

    if @recipe.update(recipe_params)
      flash[:success] = "Awesome, your changes have been saved."
      redirect_to @recipe
    else
      render :edit
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe = Recipe.find(params[:id])
    authorize! :destroy, @recipe

    @recipe.destroy
    @recipes = Task.accessible_by(current_ability)
    flash[:alert] = "Your recipe has been deleted."
    redirect_to recipes_url
  end

  private

    def user_is_current_user
      unless Recipe.find(params[:user_id])  == current_user.id
        flash[:notice] = "You may only view your own recipes."
        redirect_to root_path
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow trusted parameters
    def recipe_params
      params.require(:recipe).permit(:title, :description, :ingredients, :instructions, :user_id)
    end
end
