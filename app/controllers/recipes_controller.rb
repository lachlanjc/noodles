class RecipesController < ApplicationController
  include ApplicationHelper
  include MarkdownHelper
  include RecipesHelper
  include ScrapingHelper

  before_filter :please_sign_in, only: [:index, :create]
  before_filter :set_recipe, only: [:show, :edit, :update, :update_notes, :destroy]
  before_filter :locate_recipe, only: [:notes, :export_pdf, :remove_image, :share_this_recipe, :un_share]
  before_filter :not_the_owner, only: [:update, :notes, :export_pdf, :remove_image, :share_this_recipe, :un_share, :destroy]
  protect_from_forgery except: :embed_js

  def index
    @recipes = current_user.recipes.order(:title)
  end

  def show
    render :locked, status: 403 if not_my_recipe?
  end

  def new
    if user_signed_in?
      @recipe = Recipe.new
      render :edit
    else
      flash[:red] = 'You must have an account to create new recipes.'
      redirect_to root_url
    end
  end

  def edit
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @recipe.shared = false

    if @recipe.save
      @recipe.shared_id = generate_shared_id(@recipe.id)
      @recipe.save
      flash[:green] = "Awesome, you've saved your new recipe."
      redirect_to @recipe
    else
      render :edit
    end
  end

  def update
    if @recipe.update(recipe_params)
      @recipe.save
      flash[:green] = "Great, your changes were saved."
      if params[:cook]
        redirect_to recipe_cook_path(@recipe)
      else
        redirect_to @recipe
      end
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash[:green] = "Okay, we've got that recipe in the recycling bin now."
    redirect_to recipes_url
  end

  def notes
    @notes_blankslate = "<p>No notes for this recipe yet.</p>".html_safe if @recipe.notes.blank?
  end

  def update_notes
    if @recipe.update(recipe_params)
      @recipe.save
      render :notes
    end
  end

  def export_pdf
    prawnto filename: @recipe.title, inline: true
    render "recipes/show.pdf"
  end

  def embed_js
    @recipe = Recipe.find_by_shared_id(params[:shared_id])
    render "recipes/embed.js", layout: false
  end

  def share_this_recipe
    @recipe.shared = true
    @recipe.save
    redirect_to shared_path
  end

  def share
    @recipe = Recipe.find_by_shared_id(params[:shared_id])
    raise_not_found
    @shared_url = shared_url
  end

  def un_share
    @recipe.shared = false
    @recipe.save
    flash[:grey] = 'Your recipe is all locked up now. 🔐'
    redirect_to @recipe
  end

  def save_to_noodles
    @recipe = Recipe.find(params[:shared_id])
    raise_not_found
    @save_recipe = Recipe.new do |r|
      r.user_id = current_user.id
      r.title = @recipe.title
      r.description = @recipe.description
      r.img = @recipe.img
      r.ingredients = @recipe.ingredients
      r.instructions = @recipe.instructions
      r.source = shared_url
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

  def remove_image
    @recipe.img = nil
    @recipe.save
    if params[:cook]
      redirect_to recipe_cook_path(@recipe)
    else
      redirect_to edit_recipe_path(@recipe)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
      raise_not_found
    end

    def locate_recipe
      @recipe = Recipe.find(params[:recipe_id])
      raise_not_found
    end

    def raise_not_found
      raise ActiveRecord::RecordNotFound if @recipe.nil?
    end

    # Only allow trusted parameters
    def recipe_params
      params.require(:recipe).permit(:title, :description, :img, :ingredients, :instructions, :favorite, :source, :author, :serves, :notes, :shared_id, { collections: [] })
    end

    def not_the_owner
      if not_my_recipe?
        flash[:red] = 'That\'s not yours.'
        redirect_to root_url
      else
        true
      end
    end
end
