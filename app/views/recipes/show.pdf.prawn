font_families.update(
  'Lato' => { normal: Rails.root.join('lib/assets/pdf_fonts/Lato-Regular.ttf').to_s,
              italic: Rails.root.join('lib/assets/pdf_fonts/Lato-Italic.ttf').to_s,
              bold: Rails.root.join('lib/assets/pdf_fonts/Lato-Bold.ttf').to_s,
              bold_italic: Rails.root.join('lib/assets/pdf_fonts/Lato-BoldItalic.ttf').to_s }
)

font 'Lato' do
  default_leading 6
  fill_color '333333'

  text @recipe.title, size: 30
  move_down 10

  if @recipe.description.present?
    text @recipe.description
    move_down 10
  end

  text 'Ingredients', size: 16, style: :bold
  text @recipe.ingredients
  move_down 10

  text 'Instructions', size: 16, style: :bold
  text plain_text_from_markdown(@recipe.instructions).strip
  move_down 10

  if details?
    text 'Details', size: 16, style: :bold
    text "Source: #{remove_url_head @recipe.source}" if @recipe.source.present?
    text "Author: #{@recipe.author}" if @recipe.author.present?
    text "Yield: #{@recipe.serves}" if @recipe.serves.present?
    move_down 10
  end

  if @recipe.notes.present?
    text 'Notes', size: 16, style: :bold
    text @recipe.notes
    move_down 10
  end

  text 'Saved from Noodles, a simple app to keep, cook, and share your recipes.', inline_format: true, color: '585e67'
  text 'Try it free: <u>https://getnoodl.es/</u>', inline_format: true, color: '585e67'
end
