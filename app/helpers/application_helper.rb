module ApplicationHelper
  include DeviseHelper

  def flash_color_class(level)
    case level.to_sym
    when :grey then 'grey-3'
    when :green then 'green'
    when :red then 'red'
    when :alert then 'red'
    when :blue then 'blue'
    when :notice then 'blue'
    else 'grey-3'
    end
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def go_back
    redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end

  def please_sign_in
    if nobody_signed_in?
      flash[:red] = 'Please sign in to an account.'
      redirect_to root_url
    end
  end

  def app_url
    Rails.env.development? ? 'http://noodles.dev' : 'https://getnoodl.es'
  end

  def modal_close
    content_tag(:action, inline_svg('close.svg', class: 'fill-grey-4'), 'data-behavior': 'modal_close', class: 'db fr')
  end

  def modal_header(text)
    html = modal_close
    html << content_tag(:h2, text, class: 'mtn')
    html << tag(:hr)
    html
  end
end
