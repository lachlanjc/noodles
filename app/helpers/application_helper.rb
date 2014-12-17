module ApplicationHelper
  def flash_class(level)
    case level.to_sym
      when :info then 'flash-info'
      when :success then 'flash-success'
      when :danger then 'flash-danger'
      when :view then 'flash-danger'
    end
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def markdown(str)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, underline: true, space_after_headers: true, strikethrough: true)
    return md.render(str).html_safe
  end
end
