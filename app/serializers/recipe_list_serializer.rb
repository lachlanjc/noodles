class RecipeListSerializer < BaseSerializer
  cache key: 'recipe_list'

  attributes :id, :title, :description, :path, :public_path,
    :favorite, :notes, :photo, :collections

  def notes
    object.notes.present?
  end

  def photo
    object.imaged?
  end

  def collections
    object.collections.present?
  end

  def web
    from_web?(object.source)
  end

  def path
    recipe_path(object)
  end

  def public_path
    share_path(object.shared_id)
  end
end
