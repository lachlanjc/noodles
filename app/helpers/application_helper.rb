module ApplicationHelper
  include MarkdownHelper

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
end
