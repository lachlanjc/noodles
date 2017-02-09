class RecipeSerializer < BaseSerializer
  attributes :id,
    :title, :description, :photo, :favorite, :user_id,
    :ingredients, :instructions, :source, :author, :serves,
    :shared_id, :path, :public_path

  def photo
    object.img.url
  end

  def path
    recipe_path(object)
  end

  def public_path
    share_path(object.shared_id)
  end
end
