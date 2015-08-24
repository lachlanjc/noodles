module ApplicationHelper
  include MarkdownHelper

  def flash_color_class(level)
    case level.to_sym
    when :grey then "grey-2"
    when :green then "green"
    when :red then "red"
    else "grey-3"
    end
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def modal_close
    "<div class='fill-grey-4 block right pointer js-modal-close'>#{inline_svg('close.svg')}</div>".html_safe
  end
end
