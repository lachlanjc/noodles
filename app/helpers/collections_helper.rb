module CollectionsHelper
  def generate_hash_id(id)
    return Hashids.new("60001302015").encode(id * 1302015)
  end

  def me_owns_collection?
    if current_user && @collection.user.id == current_user.id
      return true
    else
      return false
    end
  end
end
