module ApplicationHelper
  def flash_class(level)
    case level.to_sym
      when :info then "flash flash-info"
      when :success then "flash flash-success"
      when :danger then "flash flash-danger"
      when :view then "flash flash-danger"
      else "flash"
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
