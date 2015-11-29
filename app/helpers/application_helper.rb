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
    fail ActionController::RoutingError.new('Not Found')
  end

  def go_back
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def nobody_signed_in?
    !user_signed_in?
  end

  def please_sign_in
    return false if user_signed_in?
    flash[:red] = 'Please sign in to an account.'
    redirect_to root_url
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

  def hidden_if(conditions)
    'style="display: none;"'.html_safe if conditions
  end

  def render_params
    params.delete_if { |key| key == 'controller' || key == 'action' }
  end
end
