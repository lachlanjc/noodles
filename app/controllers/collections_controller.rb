class CollectionsController < ApplicationController
  include ApplicationHelper
  include CollectionsHelper

  before_action :set_collection, except: [:index, :share, :create]
  before_filter :authenticate_user!, except: [:share]
  before_filter :only_mine, only: [:show, :update, :destroy]

  def index
    @collections = current_user.collections
    @collection = Collection.new
  end

  def show
    populate_collection
    setup_shared_url
  end

  def share
    if params[:shared_id]
      @collection = Collection.find_by_shared_id(params[:shared_id])
    else
      set_collection
    end
    populate_collection
    setup_shared_url
  end

  def create
    @collection = Collection.new(collection_params)
    @collection.user = current_user
    @collection.save
    redirect_to @collection
  end

  def update
    @collection.update(collection_params)
    redirect_to @collection
  end

  def destroy
    @collection.destroy
    flash[:green] = 'Your collection is no more.'
    redirect_to collections_path
  end

  private

  def set_collection
    @collection = Collection.find(params[:id])
    raise_not_found
  end

  def raise_not_found
    raise ActiveRecord::RecordNotFound if @collection.nil?
  end

  def collection_params
    params.require(:collection).permit(:name, :description, :photo, :user_id)
  end

  def populate_collection
    @recipes = []
    @collection.user.recipes.each do |recipe|
      @recipes.push(recipe) if recipe.collections.include?(@collection.id.to_s)
    end
  end

  def only_mine
    if not_my_collection?
      flash[:red] = 'That\'s not yours.'
      redirect_to root_url
    end
  end

  def setup_shared_url
    @shared_url = shared_coll_url
  end
end
