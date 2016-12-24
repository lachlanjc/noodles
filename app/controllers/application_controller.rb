class ApplicationController < ActionController::Base
  include DeviseHelper

  protect_from_forgery with: :exception
  layout proc { false if request.xhr? }
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

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

  def flash_or_text(flash_color, plain_text, flash_text = plain_text)
    if request.xhr?
      render text: plain_text
    else
      flash[flash_color] = flash_text
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name])
  end

  def record_not_found
    flash[:danger] = "We can't find that. 😐"
    redirect_to root_url
  end
end
