json.recipes @recipes do |recipe|
  json.extract! recipe, :id, :title, :favorite, :user_id
  json.description_preview recipe.description_truncated

  json.notes recipe.notes.present?
  json.photo recipe.img.url.present?
  json.collections recipe.collections.present?
  json.web from_web?(recipe.source)
  json.url recipe_path(recipe)
  json.shared_url shared_path(recipe)
end
