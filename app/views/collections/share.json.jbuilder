json.collection do
  json.extract! @collection, :name, :description, :id, :shared_id, :user_id
  json.publisher @collection.user.first_name
  json.photo @collection.photo.url
  json.partial! 'shared/recipe_list_public', recipes: @recipes
end
