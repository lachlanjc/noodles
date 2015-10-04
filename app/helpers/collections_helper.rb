module CollectionsHelper
  def generate_hash_id(id)
    Hashids.new('60001302015').encode(id * 1_302_015)
  end

  def me_owns_collection?
    user_signed_in? && @collection.user.id == current_user.id
  end
end
