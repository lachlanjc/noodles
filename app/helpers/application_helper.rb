module ApplicationHelper
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

  def please_sign_in
    if !user_signed_in?
      flash[:red] = 'Please sign in to an account.'
      redirect_to root_url
    end
  end

  def app_url
    Rails.env.development? ? 'http://noodles.dev' : 'http://www.getnoodl.es'
  end

  def modal_close
    "<div class='fill-grey-4 block right pointer' data-behavior='modal_close'>#{inline_svg('close.svg')}</div>".html_safe
  end
end
