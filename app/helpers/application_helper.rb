module ApplicationHelper
  include MarkdownHelper

  def flash_color_class(level)
    case level.to_sym
    when :info then "blue"
    when :success then "green"
    when :danger then "red"
    else "grey-2"
    end
  end

  def title(page_title)
    content_for(:title) { page_title }
  end
end
