require 'redcarpet'

module MarkdownHelper
  def markdown(str)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, underline: true, space_after_headers: true, strikethrough: true)
    rendered = md.render(str)
    return rendered.html_safe
  end
end
