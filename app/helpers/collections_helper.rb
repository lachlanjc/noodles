module CollectionsHelper
  def me_owns_collection?
    user_signed_in? && @collection.user.id == current_user.id
  end
end
