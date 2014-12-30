class RecipesController < ApplicationController
  before_filter :set_recipe, only: [:show, :edit, :update, :destroy, :save_to_noodles]

  # GET /recipes
  def index
    if user_signed_in?
      @recipes = if params[:favorites]
        Recipe.where(:favorite => true)
      else
        Recipe.all
      end.where(:user_id => current_user.id).order(created_at: :desc)

      @recipes_count = @recipes.count
      @favorites_count = @recipes.where(:favorite => true).count

      case @recipes_count
      when 0 then render :no_recipes_yet
      else render :recipe_list
      end
    else
      redirect_to 'http://www.getnoodl.es'
    end
  end

  # GET /recipes/1
  def show
    if current_user && @recipe.user_id == current_user.id
      set_recipe

      respond_to do |format|
        format.html
        format.json { render json: @recipe }
      end
    else
      render :locked
    end
  end

  def random_recipe
    if current_user
      recipes = Recipe.where(:user_id => current_user.id)
      @recipe = recipes[rand(recipes.size)]
      redirect_to recipe_url(@recipe)
    else
      flash[:danger] = "Please sign in to find a random recipe."
      redirect_to root_url
    end
  end

  def remove_image
    recipe = Recipe.find(params[:recipe_id])

    if current_user && recipe.user_id == current_user.id
      recipe.img = nil
      recipe.save
      redirect_to edit_recipe_path(recipe)
    else
      flash[:danger] = "That's not your recipe!"
      redirect_to root_url
    end
  end

  def share
    @recipe = Recipe.find(params[:id])

    if current_user && @recipe.user_id == current_user.id && @recipe.shared == false
      @recipe.shared = true
      @recipe.save
      render :share
    elsif @recipe.shared == false
      render :locked
    else
      render :share
    end
  end

  def un_share
    @recipe = Recipe.find(params[:recipe_id])

    if current_user && @recipe.user_id == current_user.id && @recipe.shared == true
      @recipe.shared = false
      @recipe.save
      redirect_to @recipe
    end
  end

  def save_to_noodles
    @save_recipe = Recipe.new do |r|
      r.user_id = current_user.id
      r.title = @recipe.title
      r.description = @recipe.description
      r.img = @recipe.img
      r.ingredients = @recipe.ingredients
      r.instructions = @recipe.instructions
      r.instructions_rendered = @recipe.instructions_rendered
      r.source = 'http://app.getnoodl.es/s/' + @recipe.id.to_s
      r.serves = @recipe.serves
      r.notes = @recipe.notes
      r.favorite = false
      r.shared = false
      r.created_at = Time.now
      r.updated_at = Time.now
      r.save
    end
    flash[:success] = "#{@save_recipe.title} (published by #{User.find(@recipe.user_id).first_name}) has been saved to your Noodles account."
    redirect_to @save_recipe
  end

  # GET /recipes/new
  def new
    if current_user
      @recipe = Recipe.new
      render :edit
    else
      flash[:info] = "You must sign up or sign in to create new recipes."
      redirect_to root_url
    end
  end

  # GET /recipes/1/edit
  def edit
    if @recipe.user_id == current_user.id
      render :edit
    else
      flash[:view] = "Sorry, you can't edit that recipe."
      redirect_to root_url
    end
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @recipe.shared = false
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
    flash[:danger] = "Your recipe has been deleted."
    redirect_to recipes_url
  end

  private
    # Markdown processing
    def markdown(str)
      md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, underline: true, space_after_headers: true, strikethrough: true)
      return md.render(str)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow trusted parameters
    def recipe_params
      params.require(:recipe).permit(:title, :description, :img, :ingredients, :instructions, :favorite, :source, :serves, :notes)
    end
end
