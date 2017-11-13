class CollectionSerializer < BaseSerializer
  cache key: 'collection'

  attributes :id,
             :name, :description, :photo, :publisher, :recipes,
             :user_id, :shared_id, :path, :public_path

  def photo
    object.photo_url
  end

  def publisher
    object.user.first_name
  end

  def recipes
    ActiveModelSerializers::SerializableResource.new(object.recipes, each_serializer: RecipeListSerializer).as_json
  end

  def path
    collection_path(object)
  end

  def public_path
    coll_share_path(object.shared_id)
  end
end
