json.collection do
  json.extract! @collection, :name, :description, :id, :hash_id, :user_id
  json.photo @collection.photo.url
  json.partial! 'shared/recipe_list', recipes: @recipes
end
