json.recipe do
  json.extract! @recipe, :id, :favorite, :user_id
  json.extract! @recipe, :title, :description, :ingredients, :instructions, :source, :author, :serves
  json.shared_url shared_url
  json.notes_rendered notes_rendered
  json.notes_text @recipe.notes
end
