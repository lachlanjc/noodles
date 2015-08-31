font "Helvetica"
default_leading 4
fill_color "333333"

text @recipe.title, :size => 30
move_down 15

text @recipe.description
move_down 15

text "Ingredients", :size => 21
text @recipe.ingredients
move_down 15

text "Instructions", :size => 21
text plain_text_from_markdown(@recipe.instructions)
move_down 15

unless @recipe.source.blank? && @recipe.serves.blank?
  text "Details", :size => 21
  text "Source: #{@recipe.source}"
  text "Yield: #{@recipe.serves}"
  move_down 15
end

unless @recipe.notes.blank?
  text "Notes", :size => 21
  text @recipe.notes
  move_down 15
end

text "Saved from Noodles, a simple app to keep, cook, and share your recipes.", :inline_format => :true, :color => "666d78"
text "Try it free at <u>http://www.getnoodl.es/</u>", :inline_format => :true, :color => "666d78"
