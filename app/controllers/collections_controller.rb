class CollectionsController < ApplicationController
  include CollectionsHelper

  before_action :please_sign_in, except: [:show, :share]
  before_action :set_collection, except: [:index, :create]
  before_action -> { hey_thats_my @collection }, except: [:index, :create, :show, :share]

  def index
    @collections = current_user.collections
    @collections_json = ActiveModelSerializers::SerializableResource.new(@collections, each_serializer: CollectionListSerializer).as_json
    @collection = Collection.new
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @collections_json }
    end
  end

  def show
    if is_my? @collection
      @collection_json = ActiveModelSerializers::SerializableResource.new(@collection, serializer: CollectionSerializer).as_json
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @collection_json }
      end
    else
      render_locked @collection
    end
  end

  def share
    @collection_json = ActiveModelSerializers::SerializableResource.new(@collection, serializer: CollectionSerializer).as_json
    respond_to do |format|
      format.html { render :share }
      format.json { render json: @collection_json }
    end
  end

  def create
    @collection = Collection.new(collection_params.merge({ user: current_user }))
    respond_to do |format|
      if @collection.save
        format.html { redirect_to collection_path(@collection) }
        format.json { render json: @collection, status: :created, location: @collection }
      end
    end
  end

  def update
    @collection.update(collection_params)
    redirect_to @collection
  end

  def destroy
    @collection.destroy
    flash[:success] = 'The collection has been deleted.'
    redirect_to collections_url
  end

  private

  def set_collection
    @collection = Collection.includes(:user).find_by regular_or_shared_id
    # raise_not_found
    @recipes = @collection.recipes
  end

  def raise_not_found
    raise ActiveRecord::RecordNotFound if @collection.nil?
  end

  def collection_params
    params.require(:collection).permit(:name, :description, :photo)
  end
end
