class CollectionsController < ApplicationController
  include CollectionsHelper

  before_action :set_collection, except: [:index, :create]
  before_filter :authenticate_user!, except: [:share]
  before_filter :only_mine, only: [:show, :update, :destroy]

  def index
    @collections = current_user.collections
    @collection = Collection.new
  end

  def show
    populate_collection
    @shared_url = shared_coll_url
  end

  def share
    populate_collection
    @shared_url = shared_coll_url
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
    flash[:success] = 'The collection is in the trash.'
    redirect_to collections_path
  end

  private

  def set_collection
    if params[:shared_id]
      @collection = Collection.find_by(shared_id: params[:shared_id])
    else
      @collection = Collection.find(params[:id])
    end
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
      flash[:danger] = 'That\'s not yours.'
      redirect_to root_url
    end
  end
end
