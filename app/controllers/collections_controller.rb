class CollectionsController < ApplicationController
  include ApplicationHelper
  include CollectionsHelper

  before_action :set_collection, except: [:index, :share, :create]
  before_filter :only_mine, only: [:show, :update, :destroy]

  def index
    authenticate_user!
    @collections = current_user.collections
    @collection = Collection.new
  end

  def show
    populate_collection
  end

  def share
    if params[:hash_id]
      @collection = Collection.find_by_hash_id(params[:hash_id])
    rescue ActiveRecord::RecordNotFound
      flash[:red] = "We can't find that collection."
      redirect_to root_url
    else
      set_collection
    end
    populate_collection
  end

  def create
    # Super messy!
    @collection = Collection.new do |c|
      c.name = params[:collection][:name]
      c.description = params[:collection][:description]
      c.photo = params[:collection][:photo]
      c.user = current_user
      c.save!
    end
    @collection.hash_id = generate_hash_id(@collection.id)
    @collection.save
    redirect_to @collection
  end

  def update
    @collection.update(collection_params)
    redirect_to @collection
  end

  def destroy
    @collection.destroy
    flash[:red] = "Your collection is no more."
    redirect_to collections_path
  end

  private
    def set_collection
      @collection = Collection.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:red] = "We can't find that collection."
      redirect_to root_url
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
      not_found unless me_owns_collection?
    end
end
