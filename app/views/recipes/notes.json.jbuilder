json.recipe do |recipe|
  json.notes_rendered markdown(@recipe.notes)
  json.notes_text @recipe.notes
end
