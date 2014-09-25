require 'redcarpet'

module MarkdownHelper
  def markdown(str)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    rendered = md.render(str)
    return rendered.html_safe
  end
end
