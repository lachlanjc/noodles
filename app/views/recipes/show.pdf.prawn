font_families.update('Sentinel' => {
  normal: Rails.root.join('lib/assets/pdf_fonts/Sentinel-Book.ttf').to_s,
  italic: Rails.root.join('lib/assets/pdf_fonts/Sentinel-BookItalic.ttf').to_s,
  bold: Rails.root.join('lib/assets/pdf_fonts/Sentinel-Semibold.ttf').to_s,
  bold_italic: Rails.root.join('lib/assets/pdf_fonts/Sentinel-SemiboldItalic.ttf').to_s
})

font 'Sentinel'
fallback_fonts ['Times-Roman']

text @recipe.title, size: 32, style: :bold
move_down 8

default_leading 6

if @recipe.description.present?
  text @recipe.description
  move_down 8
end

text 'Ingredients', size: 18, style: :bold
@recipe.ingredients.to_s.lines.each do |line|
  text line.gsub(/#+ (.+)/, '<b>\1</b>'), inline_format: true
end
move_down 8

text 'Instructions', size: 18, style: :bold
text plain_text_from_markdown(@recipe.instructions).strip
move_down 8

if details?
  text 'Details', size: 18, style: :bold
  text "Source: #{remove_url_head @recipe.source}" if @recipe.source.present?
  text "Author: #{@recipe.author}" if @recipe.author.present?
  text "Yield: #{@recipe.serves}" if @recipe.serves.present?
  move_down 8
end

if @recipe.notes.present?
  text 'Notes', size: 18, style: :bold
  text @recipe.notes
  move_down 8
end

text "Saved from Noodles — one place for all your recipes. <u><link href='https://getnoodl.es'>https://getnoodl.es</link></u>", inline_format: true, color: '585e67'
