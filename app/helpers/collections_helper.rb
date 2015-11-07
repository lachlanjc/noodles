module CollectionsHelper
  include ApplicationHelper

  def me_owns_collection?(collection = @collection)
    user_signed_in? && collection.user.id == current_user.id
  end

  def not_my_collection?(collection = @collection)
    !me_owns_collection?(collection)
  end

  def shared_coll_path(collection = @collection)
    "/c/#{collection.shared_id.to_s}"
  end

  def shared_coll_url(collection = @collection)
    app_url + shared_coll_path(collection)
  end
end
