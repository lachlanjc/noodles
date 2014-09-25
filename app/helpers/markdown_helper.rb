require 'redcarpet'

module MarkdownHelper
  def markdown(str)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, underline: true, space_after_headers: true, strikethrough: true)
    return md.render(str).html_safe
  end
end
