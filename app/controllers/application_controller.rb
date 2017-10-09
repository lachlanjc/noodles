class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout proc { false if request.xhr? }
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  helper_method :nobody_signed_in?, :current_user_id, :is_my?, :isnt_my?,
    :public_page?, :private_page?
  # include Webpacker::Helper

  # Keep the current user id in memory
  def current_user_id
    return unless current_user
    session[:user_id] ||= current_user.id
    session[:user_id]
  end

  # Is anyone signed in?
  def someone_signed_in?
    current_user_id.present?
  end

  # The opposite of there being someone signed in
  def nobody_signed_in?
    !someone_signed_in?
  end

  # Go back
  def go_back
    redirect_back(fallback_location: help_path)
  end

  # Render 404 page
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  # Redirect visitor if they're not signed in
  def please_sign_in
    if nobody_signed_in?
      flash[:danger] = 'Please sign in to Noodles first.'
      redirect_to new_user_registration_path
    end
  end

  # Is this thing mine?
  def is_my?(object)
    someone_signed_in? && object.user_id == current_user_id
  end

  # Is this thing _not_ mine?
  def isnt_my?(object)
    !is_my? object
  end

  # Redirect user if the current object isn't theirs
  def hey_thats_my(object)
    please_sign_in
    if isnt_my? object
      flash[:danger] = "That's not yours."
      redirect_to root_url
    end
  end

  # Render the locked page
  def render_locked(object)
    render 'shared/locked', locals: { object: object }, status: 403
  end

  # Show flash on html request, render text on xhr request
  def flash_or_text(flash_color, plain_text, flash_text = plain_text)
    if request.xhr?
      render text: plain_text
    else
      flash[flash_color.to_sym] = flash_text
    end
  end

  # Abstraction for find_by; finds using the shared or regular id param
  def regular_or_shared_id
    ids = params.values_at(:id, :shared_id)
    ids[1] ? { shared_id: ids[1] } : { id: ids[0] }
  end

  # Is this a public sharing page?
  def public_page?
    params[:action].to_sym == :share
  end

  # Is this NOT a public sharing page?
  def private_page?
    !public_page?
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
