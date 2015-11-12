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
    setup_image_layout if @recipe.img.present?
    @shared_url = shared_url
    render :locked, status: 403 if not_my_recipe?
  end

  def new
    if user_signed_in?
      @recipe = Recipe.new
      title_setup
      render :edit
    else
      flash[:red] = 'You need to be signed in to save recipes.'
      redirect_to root_url
    end
  end

  def edit
    title_setup
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @recipe.shared = false

    if @recipe.save
      flash[:green] = 'Awesome, you\'ve saved your new recipe.'
      redirect_to @recipe
    else
      render :edit
    end
  end

  def update
    if @recipe.update(recipe_params)
      @recipe.save
      flash[:green] = 'Great, your changes were saved.'
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
    flash[:green] = 'Okay, we\'ve got that recipe in the recycling bin now.'
    redirect_to recipes_url
  end

  def notes
  end

  def update_notes
    if @recipe.update(recipe_params)
      @recipe.save
      render :notes
    end
  end

  def export_pdf
    prawnto filename: @recipe.title, inline: true
    render 'recipes/show.pdf'
  end

  def embed_js
    @recipe = Recipe.find_by_shared_id(params[:shared_id])
    render 'recipes/embed.js', layout: false
  end

  def share_this_recipe
    @recipe.shared = true
    @recipe.save
    redirect_to shared_path
  end

  def share
    @recipe = Recipe.find_by_shared_id(params[:shared_id])
    raise_not_found
    setup_image_layout if @recipe.img.present?
    @shared_url = shared_url
  end

  def un_share
    @recipe.shared = false
    @recipe.save
    flash[:grey] = 'Your recipe is all locked up now. 🔐'
    redirect_to @recipe
  end

  def save_to_noodles
    @recipe = Recipe.find_by_shared_id(params[:shared_id])
    raise_not_found
    @new_recipe = Recipe.new do |r|
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
    @new_recipe.save
    flash[:green] = "#{@recipe.title} has been saved!"
    redirect_to @new_recipe
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

  def title_setup
    @title = @recipe.title || params[:title].to_s.capitalize.squish
  end

  def setup_image_layout
    safely do
      size = FastImage.size @recipe.img.url
      if size.present?
        if size[0].to_i > 750
          @image_layout = true
          @remove_grey_bg = false
          @hide_flash = flash.any?
        end
      end
    end
    @image_layout = defined? @image_layout
  end
end
