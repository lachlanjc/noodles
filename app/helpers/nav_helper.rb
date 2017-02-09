module NavHelper
  include ActionView::Helpers::CaptureHelper

  def nav_active_class(nav)
    nav_active?(nav) ? 'nav__link phs b' : 'nav__link phs'
  end

  def nav_active?(nav)
    @navs ||= []
    @navs.include?(nav.to_sym)
  end

  def activate_nav!(nav)
    @navs ||= []
    @navs.push(nav.to_sym)
  end

  def flash_json
    flash.to_a.each do |f|
      f[0] = flash_type(f[0])
    end
  end

  def flash_type(level)
    case level.to_sym
    when :grey then nil
    when :success, :green then 'success'
    when :danger, :alert, :red then 'danger'
    when :notice, :blue then 'info'
    else 'message'
    end
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def remove_grey_bg!
    content_for(:body_classes) { 'bg-white' }
  end

  def body_classes
    if content_for?(:bg_img)
      'bg-no-repeat bg-center bg-cover'
    else
      content_for(:body_classes) || 'bg-grey-5'
    end
  end

  def flag_page?
    controllers = %w(devise/registrations devise/sessions pages).include?(params[:controller])
    actions = %w(share subscribe).include?(params[:action])
    user_signed_in? && !controllers && !actions
  end
end
