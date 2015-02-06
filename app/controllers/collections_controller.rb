class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  def index
    @collections = Collection.where(:user_id => current_user)
  end

  def show
    @recipes = []
    Recipe.where(:user_id => current_user.id).each do |recipe|
      @recipes.push(recipe) if recipe.collections.include?(@collection.id.to_s)
    end
  end

  end

  def create
    @collection = Collection.new(collection_params)
    @collection.user_id = current_user.id

    if @collection.save
      collection_flash = "Boom. You created a new collection"
      redirect_to @collection
    end
  end

  def update
    @collection.update(collection_params)
    redirect_to @collection
  end

  def destroy
    @collection.destroy
    flash[:danger] = "Buckle up! We're deleting your collection."
    redirect_to collections_path
  end

  private
    def set_collection
      @collection = Collection.find(params[:id])
    end

    def collection_params
      params.require(:collection).permit(:name, :description, :photo, :user_id)
    end
end
