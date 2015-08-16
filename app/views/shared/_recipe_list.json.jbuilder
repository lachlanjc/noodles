json.recipes @recipes do |recipe|
  json.extract! recipe, :id, :title, :favorite, :user_id
  json.description_preview recipe.description.truncate(164)

  json.notes recipe.notes.present?
  json.photo recipe.img.url.present?
  json.collections recipe.collections.present?
  json.web is_from_web(recipe.source)
  json.url "/recipes/" + recipe.id.to_s
  json.shared_url "/s/" + recipe.shared_id.to_s
end
