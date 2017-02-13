class CollectionListSerializer < BaseSerializer
  cache key: 'collection_list'

  attributes :id,
    :name, :description, :photo, :user_id,
    :shared_id, :path, :public_path

  def photo
    object.photo_url
  end

  def path
    collection_path(object)
  end

  def public_path
    share_path(object.shared_id)
  end
end
