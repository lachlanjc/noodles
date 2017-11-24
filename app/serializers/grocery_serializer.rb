class GrocerySerializer < ActiveModel::Serializer
  attributes :id, :name, :completed_at
  has_one :user
end
