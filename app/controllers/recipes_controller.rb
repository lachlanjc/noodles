class RecipesController < ApplicationController
  include ApplicationHelper
  include MarkdownHelper
  include RecipesHelper
  include ScrapingHelper

  before_filter :please_sign_in, only: [:index, :favorites, :random, :create]
  before_filter :set_recipe, only: [:show, :edit, :update, :update_notes, :destroy]
  before_filter :locate_recipe, only: [:notes, :export_pdf, :remove_image, :share_this_recipe, :un_share]
  before_filter :not_the_owner, only: [:update, :notes, :export_pdf, :remove_image, :share_this_recipe, :un_share, :destroy]
  protect_from_forgery except: :embed_js

  # GET /recipes
  def index
    @recipes = current_user.recipes.order(created_at: :desc)
    render :recipe_list
  end

  def favorites
    @recipes = Recipe.where(:user_id => current_user.id, :favorite => true).order(created_at: :desc)

    if @recipes.any?
      render :favorites
    else
      redirect_to "http://noodles.withdraft.com/#favorites"
    end
  end

  # GET /recipes/1
  def show
    if me_owns_recipe?
      @shared_url = shared_url(@recipe)
      @embed_code = '<script src="http://www.getnoodl.es/embed/' + @recipe.shared_id.to_s + '"></script>'
    else
      render :locked, status: 403
    end
  end

  def notes
    @notes_blankslate = "<p>No notes for this recipe yet.</p>".html_safe if @recipe.notes.blank?
  end

  def export_pdf
    prawnto filename: @recipe.title, :inline => true
    render "recipes/show.pdf"
  end

  def embed_js
    @recipe = Recipe.find_by_shared_id(params[:shared_id])
    render "recipes/embed.js", layout: false
  end

  def random
    if current_user.recipes.count == 0
      flash[:blue] = "Hold it, you don't have any recipes yet!"
      redirect_to onboarding_path
    else
      recipe = current_user.recipes.order("RANDOM()").first
      flash[:grey] = "Here's your random recipe."
      redirect_to recipe_path(recipe)
    end
  end

  def remove_image
    @recipe.img = nil
    @recipe.save
    redirect_to edit_recipe_path(@recipe)
  end

  def share_this_recipe
    @recipe.shared = true
    @recipe.save
    redirect_to shared_url(@recipe)
  end

  def share
    @recipe = Recipe.find_by_shared_id(params[:shared_id])
    @owner = User.find(@recipe.user_id).first_name
    @shared_url = shared_url(@recipe)
  end

  def un_share
    @recipe.shared = false
    @recipe.save
    flash[:green] = "That recipe is locked up again."
    redirect_to @recipe
  end

  def save_to_noodles
    @recipe = Recipe.find_by_shared_id(params[:shared_id])
    @save_recipe = Recipe.new do |r|
      r.user_id = current_user.id
      r.title = @recipe.title
      r.description = @recipe.description
      r.img = @recipe.img
      r.ingredients = @recipe.ingredients
      r.instructions = @recipe.instructions
      r.source = shared_url(@recipe)
      r.serves = @recipe.serves
      r.notes = @recipe.notes
      r.favorite, r.shared = false
      r.save
    end
    @save_recipe.shared_id = generate_shared_id(@save_recipe.id)
    @save_recipe.save

    flash[:green] = "#{@save_recipe.title} is saved!"
    redirect_to @save_recipe
  end

  # GET /recipes/new
  def new
    if user_signed_in?
      @recipe = Recipe.new
      render :edit
    else
      flash[:blue] = "You must have an account to create new recipes."
      redirect_to sign_up_path
    end
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @recipe.shared = false

    if @recipe.save
      @recipe.shared_id = generate_shared_id(@recipe.id)
      @recipe.save
      flash[:green] = "Nice! Check out your new recipe:"
      redirect_to @recipe
    else
      render :edit
    end
  end

  # PATCH/PUT /recipes/1
  def update
    if @recipe.update(recipe_params)
      @recipe.save
      flash[:green] = "Great, your changes were saved."
      redirect_to @recipe
    else
      render :edit
    end
  end

  def update_notes
    if @recipe.update(recipe_params)
      @recipe.save
      render :notes
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
    flash[:red] = "Okay, we've got that recipe in the recycling bin now."
    redirect_to recipes_url
  end

  def scrape
    recipe_data = master_scrape(params[:url])

    if recipe_data == "unsupported"
      flash[:red] = "Sorry, we don't support that site yet."
      redirect_to recipes_path
    else
      create_recipe(recipe_data, params[:url], "Recipe imported!")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def locate_recipe
      @recipe = Recipe.find(params[:recipe_id])
    end

    # Only allow trusted parameters
    def recipe_params
      params.require(:recipe).permit(:title, :description, :img, :ingredients, :instructions, :favorite, :source, :author, :serves, :notes, :shared_id, { collections: [] })
    end

    def please_sign_in
      unless user_signed_in?
        flash[:red] = "Please log in to an account first!"
        redirect_to root_url
      end
    end

    def not_the_owner
      if not_my_recipe?
        flash[:red] = "That's not yours."
        redirect_to root_url
      end
    end
end
