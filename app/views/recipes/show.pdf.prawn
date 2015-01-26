font "Helvetica"
default_leading 5
fill_color "333333"

text @recipe.title, :size => 30
text "Published by #{User.find(@recipe.user_id).first_name}", :color => "707070"
move_down 5
text @recipe.description

move_down 15

text "Ingredients", :size => 21
text @recipe.ingredients

move_down 15

text "Instructions", :size => 21
text @recipe.instructions

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

text "Saved from Noodles, a simple app for all your recipes. Try it for free at <u>http://www.getnoodl.es/</u>", :inline_format => :true, :color => "707070"
