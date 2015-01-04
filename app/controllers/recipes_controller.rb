class RecipesController < ApplicationController
  include ApplicationHelper
  include RecipesHelper
  include ScrapingHelper

  before_filter :set_recipe, only: [:show, :edit, :update, :destroy, :save_to_noodles, :share]

  # GET /recipes
  def index
    if user_signed_in?
      @recipes = Recipe.where(:user_id => current_user.id).order(created_at: :desc)
      @recipes_count = @recipes.count

      case @recipes_count
      when 0 then render :no_recipes_yet
      else render :recipe_list
      end
    else
      redirect_to 'http://www.getnoodl.es'
    end
  end

  def favorites
    if user_signed_in?
      @recipes = Recipe.where(:user_id => current_user.id, :favorite => true).order(created_at: :desc)

      if @recipes.count == 0
        redirect_to 'http://noodles.withdraft.com/#favorites'
      else
        render :favorites
      end
    else
      redirect_to root_url
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

  def private_share
    @recipe = Recipe.find_by_private_id(params[:private_id])

    if @recipe.private_share == false
      @recipe.private_share = true
      @recipe.save
      render :private_share
    else
      render :private_share
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
      r.private_share = false
      r.created_at = Time.now
      r.updated_at = Time.now
      r.save
    end
    @save_recipe.private_id = generate_private_id(@save_recipe.id)
    @save_recipe.save

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
    @recipe.private_share = false
    @recipe.private_id = generate_private_id(@recipe.id)
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
    if @recipe.update(recipe_params)
      @recipe.instructions_rendered = markdown(@recipe.instructions)
      @recipe.save
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

  def scrape
    recipe_src = params[:url]
    recipe = master_scrape(recipe_src)

    if recipe == 'unsupported'
      flash[:info] = recipe
      flash[:danger] = 'Sorry, that site isn\'t supported yet.'
      redirect_to :recipes
    else
      @ingredients_prepared = write_ingredients_to_list(recipe['ingredients'])
      @instructions_prepared = form_markdown_for_instructions(recipe['instructions'])
      @instructions_rendered_prepared = markdown(@instructions_prepared.to_s)

      @create_recipe = Recipe.new do |r|
        r.user_id = current_user.id
        r.title = recipe['title']
        r.ingredients = @ingredients_prepared
        r.instructions = @instructions_prepared
        r.instructions_rendered = @instructions_rendered_prepared
        r.source = recipe_src
        r.serves = recipe['serves']
        r.notes = ''
        r.favorite = false
        r.private_share = false
        r.shared = false
        r.save
      end
      @create_recipe.description = recipe['description'].to_s
      @create_recipe.private_id = generate_private_id(@create_recipe.id)
      @create_recipe.save
      flash[:success] = 'Recipe imported!'
      redirect_to @create_recipe
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow trusted parameters
    def recipe_params
      params.require(:recipe).permit(:title, :description, :img, :ingredients, :instructions, :favorite, :source, :serves, :notes, :private_share, :private_id)
    end

    # Wombat returns arrays for ingredients and instructions.
    # These methods convert the arrays of strings into usable text.
    # The second method writes its own Markdown for the instructions.

    def write_ingredients_to_list(ingredients)
      ingredients_list = ''
      ingredients.each do |ingredient|
        # Add ingredient to the next line of ingredients_list
        # Double quotes must be used for \n
        ingredients_list << ingredient.to_s + "\n"
      end

      return ingredients_list
    end

    def form_markdown_for_instructions(steps)
      instructions_md = ''
      # each_with_index produces the step number
      steps.each_with_index do |step, id|
        # Arrays start at 0
        instructions_md << (id + 1).to_s + '. ' + step + "\n"
      end
      return instructions_md
    end
end
