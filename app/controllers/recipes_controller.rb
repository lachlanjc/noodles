class RecipesController < ApplicationController
  include ApplicationHelper
  include RecipesHelper
  include ScrapingHelper

  before_filter :set_recipe, only: [:show, :edit, :update, :destroy, :save_to_noodles]

  # GET /recipes
  def index
    if user_signed_in?
      @recipes = Recipe.where(user_id: current_user.id).search(params[:search]).order(created_at: :desc)
      @recipes_count = @recipes.count
      render :recipe_list
    else
      redirect_to root_url
    end
  end

  def favorites
    if user_signed_in?
      @recipes = Recipe.where(:user_id => current_user.id, :favorite => true).order(created_at: :desc)

      if @recipes.count == 0
        redirect_to "http://noodles.withdraft.com/#favorites"
      else
        render :favorites
      end
    else
      redirect_to root_url
    end
  end

  # GET /recipes/1
  def show
    if me_owns_recipe?
      @shared_url = shared_url(@recipe.shared_id)
      render :show
    else
      render :locked
    end
  end

  def random
    recipe = Recipe.where(:user_id => current_user.id).order("RANDOM()").first
    redirect_to recipe_url(recipe)
  end

  def remove_image
    @recipe = Recipe.find(params[:recipe_id])

    if me_owns_recipe?
      @recipe.img = nil
      @recipe.save
      redirect_to edit_recipe_path(@recipe)
    else
      flash[:danger] = "That\'s not your recipe!"
      redirect_to root_url
    end
  end

  def share_this_recipe
    @recipe = Recipe.find(params[:recipe_id])

    if me_owns_recipe?
      @recipe.shared = true
      @recipe.save
      redirect_to shared_url(@recipe.shared_id)
    else
      flash[:danger] = "No, you can\'t share someone else\'s recipes..."
      redirect_to recipes_path
    end
  end

  def share
    @recipe = Recipe.find_by_shared_id(params[:shared_id])

    if @recipe.shared == false
      render :locked
    else
      @shared_url = shared_url(@recipe.shared_id)
      render :share
    end
  end

  def un_share
    @recipe = Recipe.find(params[:recipe_id])

    if me_owns_recipe?
      @recipe.shared = false
      @recipe.save
      flash[:success] = "Recipe unshared."
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
      r.source = "http://www.getnoodl.es/s/" + @recipe.id.to_s
      r.serves = @recipe.serves
      r.notes = @recipe.notes
      r.favorite = false
      r.shared = false
      r.created_at = Time.now
      r.updated_at = Time.now
      r.save
    end
    @save_recipe.shared_id = generate_shared_id(@save_recipe.id)
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
    if me_owns_recipe?
      render :edit
    else
      flash[:view] = "Sorry, you can\'t edit that recipe."
      redirect_to root_url
    end
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @recipe.shared = false

    if @recipe.save
      @recipe.shared_id = generate_shared_id(@recipe.id)
      @recipe.instructions_rendered = markdown(@recipe.instructions)
      flash[:success] = "Your recipe has been created."
      redirect_to @recipe
    else
      render :edit
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

    if recipe == "unsupported"
      flash[:info] = recipe
      flash[:danger] = "Sorry, that site isn\'t supported yet."
      redirect_to :recipes
    else
      @ingredients_prepared = write_ingredients_to_list(recipe["ingredients"])
      @instructions_prepared = form_markdown_for_instructions(recipe["instructions"])
      @instructions_rendered_prepared = markdown(@instructions_prepared.to_s)

      @create_recipe = Recipe.new do |r|
        r.user_id = current_user.id
        r.title = recipe["title"]
        r.ingredients = @ingredients_prepared
        r.instructions = @instructions_prepared
        r.instructions_rendered = @instructions_rendered_prepared
        r.source = recipe_src
        r.serves = recipe["serves"]
        r.notes = recipe["notes"].to_s
        r.favorite = false
        r.shared = false
        r.save
      end
      @create_recipe.description = recipe["description"].to_s
      @create_recipe.shared_id = generate_shared_id(@create_recipe.id)
      @create_recipe.save
      flash[:success] = "Recipe imported!"
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
      ingredients_list = ""
      ingredients.each do |ingredient|
        # Add ingredient to the next line of ingredients_list
        # Double quotes must be used for \n
        ingredients_list << ingredient.to_s + "\n"
      end

      return ingredients_list
    end

    def form_markdown_for_instructions(steps)
      instructions_md = ""
      # each_with_index produces the step number
      steps.each_with_index do |step, id|
        # Arrays start at 0
        instructions_md << (id + 1).to_s + ". " + step + "\n"
      end
      return instructions_md
    end
end
