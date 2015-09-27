class CollectionsController < ApplicationController
  include ApplicationHelper
  include CollectionsHelper

  before_action :set_collection, except: [:index, :share, :create]
  before_filter :authenticate_user!, except: [:share]
  before_filter :only_mine, only: [:show, :update, :destroy]

  def index
    @collections = Collection.where(user_id: current_user.id)
    @collection = Collection.new
  end

  def show
    populate_collection
  end

  def share
    if params[:hash_id]
      @collection = Collection.find_by_hash_id(params[:hash_id])
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
    flash[:red] = 'Your collection is no more.'
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
      if !me_owns_collection?
        flash[:red] = 'That\'s not yours.'
        redirect_to root_url, status: 401
      end
    end
end
