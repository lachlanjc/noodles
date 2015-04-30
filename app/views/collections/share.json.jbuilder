json.collection do |collection|
  json.extract! @collection, :name, :description, :id, :hash_id, :user_id
  json.photo @collection.photo.url
end

json.partial! "shared/recipe_list_public", recipes: @recipes
