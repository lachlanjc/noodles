json.recipe do |recipe|
  json.notes_rendered @notes_blankslate || markdown(@recipe.notes)
  json.notes_text @recipe.notes
end
