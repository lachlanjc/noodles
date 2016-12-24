class RecipesController < ApplicationController
  include ApplicationHelper
  include TextHelper
  include RecipesHelper
  include ScrapingHelper

  before_filter :please_sign_in, only: [:index, :create]
  before_filter :set_recipe, except: [:index, :new, :create]
  before_filter :not_the_owner, only: [:update, :notes, :export_pdf, :remove_image, :destroy]
  before_filter :img_layout, only: [:show, :share]
  protect_from_forgery except: :embed_js

  def index
    @recipes = current_user.recipes.order(:title)
  end

  def show
    @shared_url = shared_url
    render :locked, status: 403 if not_my_recipe?
  end

  def new
    if user_signed_in?
      @recipe = Recipe.new
      title_setup
      @page_title = 'New recipe'
      render :edit
    else
      flash[:danger] = "You'll need to sign in to add recipes."
      redirect_to root_url
    end
  end

  def edit
    title_setup
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    if @recipe.save
      flash[:success] = 'New recipe saved!'
      redirect_to @recipe
    else
      render :edit
    end
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = 'Saved!'
      if request.xhr?
        render :show
      elsif request.referer.match('redirect_to=cook')
        redirect_to cook_recipe_path(@recipe)
      else
        redirect_to @recipe
      end
    else
      title_setup
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash[:success] = 'The recipe has been deleted.'
    redirect_to recipes_url
  end

  def export_pdf
    prawnto filename: @recipe.title, inline: !params[:download]
    render 'recipes/show.pdf'
  end

  def embed_js
    render js: embed_code(@recipe), layout: false
  end

  def share
    @shared_url = shared_url
  end

  def save_to_noodles
    @new_recipe = @recipe.dup
    @new_recipe.user_id = current_user.id
    @new_recipe.source = shared_url
    @new_recipe.favorite = false
    @new_recipe.save
    flash[:success] = 'Recipe saved!'
    redirect_to @new_recipe
  end

  def remove_image
    @recipe.update_attribute(:img, nil)
    if params[:cook]
      redirect_to cook_recipe_path(@recipe)
    else
      redirect_to edit_recipe_path(@recipe)
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @recipe = Recipe.find_by(shared_id: params[:shared_id]) if params[:shared_id]
    raise_not_found
  end

  def raise_not_found
    raise ActiveRecord::RecordNotFound if @recipe.nil?
  end

  # Only allow trusted parameters
  def recipe_params
    params.require(:recipe).permit(:title, :description, :img, :ingredients, :instructions, :favorite, :source, :author, :serves, :notes, :shared_id, collections: [])
  end

  def not_the_owner
    if not_my_recipe?
      flash[:red] = "That's not yours."
      redirect_to root_url
    else
      true
    end
  end

  def title_setup
    @title = @recipe.title.to_s || params[:title].to_s.capitalize.squish
  end

  def img_layout
    @image_layout = @recipe.img.present?
  end
end
