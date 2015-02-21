class CollectionsController < ApplicationController
  include CollectionsHelper

  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  def index
    @collections = Collection.where(:user_id => current_user)
  end

  def show
    populate_collection
  end

  def share
    @collection = Collection.find_by_hash_id(params[:hash_id])
    populate_collection
  end

  def create
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
    flash[:danger] = "All gone."
    redirect_to collections_path
  end

  private
    def set_collection
      @collection = Collection.find(params[:id])
    end

    def collection_params
      params.require(:collection).permit(:name, :description, :photo, :user_id)
    end

    def populate_collection
      @recipes = []
      Recipe.where(:user_id => @collection.user.id).each do |recipe|
        @recipes.push(recipe) if recipe.collections.include?(@collection.id.to_s)
      end
    end
end
