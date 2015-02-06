module CollectionsHelper
  def generate_hash_id(id)
    return Hashids.new("60001302015").encode(id * 1302015)
  end
end
