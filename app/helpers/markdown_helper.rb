module MarkdownHelper
  def markdown(str)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, underline: true, space_after_headers: true, strikethrough: true).render(str).html_safe
  end
end
