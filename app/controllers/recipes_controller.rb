class RecipesController < ApplicationController
  include ApplicationHelper
  include TextHelper
  include RecipesHelper
  include ScrapingHelper

  before_action :please_sign_in, except: %i[show share embed_js]
  before_action :set_recipe, only: %i[show share edit update destroy export_pdf embed_js remove_image collections]
  before_action -> { hey_thats_my @recipe }, only: %i[edit update destroy export_pdf remove_image collections]
  protect_from_forgery except: :embed_js

  def index
    @recipes = current_user.recipes
    @recipes_json = ActiveModelSerializers::SerializableResource.new(@recipes, each_serializer: RecipeListSerializer).as_json
    respond_to do |format|
      format.html do
        safely { analytics }
        @collections_json = ActiveModelSerializers::SerializableResource.new(current_user.collections.order(:updated_at).limit(5), each_serializer: CollectionListSerializer).as_json
        @groceries_json = ActiveModelSerializers::SerializableResource.new(current_user.groceries.order(:updated_at).limit(5), each_serializer: GrocerySerializer).as_json
      end
      format.json { render json: @recipes_json }
    end
  end

  def show
    if isnt_my? @recipe
      render_locked @recipe
    else
      respond_to do |format|
        format.html { @image_layout = @recipe.imaged? }
        format.json { render json: @recipe }
      end
    end
  end

  def new
    @recipe = Recipe.new
    title_setup
    @page_title = 'New recipe'
    render :edit
  end

  def edit
    title_setup
  end

  def create
    @recipe = Recipe.new(recipe_params.merge(user_id: current_user_id))
    if @recipe.save
      flash[:success] = 'New recipe saved!'
      redirect_to @recipe
    else
      render :edit
    end
  end

  def update
    c = params[:recipe][:collections]
    if c.is_a? String
      params[:recipe][:collections] = [c.to_i] if is_my? Collection.find(c.to_i)
    end
    if @recipe.update(recipe_params)
      flash[:success] = 'Saved!' unless @recipe.previous_changes[:collections]
      redirect_to request.params[:redirect_to] || @recipe
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
    render file: 'recipes/show.pdf',
           content_type: 'application/pdf',
           filename: @recipe.title,
           disposition: 'inline'
  end

  def embed_js
    render js: embed_code(@recipe), layout: false
  end

  def share
    @image_layout = @recipe.imaged?
    render :share
  end

  def remove_image
    @recipe.update_attribute(:img, nil)
    redirect_to params[:cook] ? cook_recipe_path(@recipe) : edit_recipe_path(@recipe)
  end

  def collections
    @collections = current_user.collections
    render partial: 'recipes/collections'
  end

  private

  def set_recipe
    @recipe = Recipe.includes(:user).find_by regular_or_shared_id
    raise_not_found
  end

  def raise_not_found
    raise ActiveRecord::RecordNotFound if @recipe.nil?
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :img, :ingredients, :instructions, :favorite, :source, :author, :serves, :notes, :shared_id, collections: [])
  end

  def title_setup
    @title =
      params[:title].to_s.strip.present? ?
      params[:title].to_s.capitalize.squish : @recipe.title.to_s
  end

  def analytics
    @analytics = {
      recipes: current_user.recipes.count,
      collections: current_user.collections.count,
      groceries: current_user.groceries.count
    }
  end
end
