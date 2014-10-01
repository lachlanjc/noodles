class RecipesController < ApplicationController
  before_filter :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  def index
    if current_user
      @recipes = Recipe.where(:user_id => current_user.id)
      @recipe_count = @recipes.count
    else
      render "home"
    end
  end

  def favorites
    if current_user
      @recipes = Recipe.where(:user_id => current_user.id, :favorite => true)
    else
      render "home"
    end
  end

  # GET /recipes/1
  def show
    if @recipe.user_id == current_user.id
      set_recipe
    else
      flash[:view] = "Sorry, you can't look at that recipe."
      redirect_to root_url
    end
  end

  # GET /recipes/new
  def new
    if current_user
      @recipe = Recipe.new
    else
      flash[:info] = "You must sign up or sign in to create new recipes."
      redirect_to root_url
    end
  end

  # GET /recipes/1/edit
  def edit
    if @recipe.user_id == current_user.id
      set_recipe
    else
      flash[:view] = "Sorry, you can't edit that recipe."
      redirect_to root_url
    end
  end

  # Markdown processing

  def markdown(str)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, underline: true, space_after_headers: true, strikethrough: true)
    return md.render(str)
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @recipe.instructions_rendered = markdown(@recipe.instructions)

    if @recipe.save
      flash[:success] = "Your recipe has been created."
      redirect_to @recipe
    else
      render :new
    end
  end

  # PATCH/PUT /recipes/1
  def update
    @recipe.instructions_rendered = markdown(@recipe.instructions)

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
      params.require(:recipe).permit(:title, :description, :img, :ingredients, :instructions, :favorite)
    end
end
