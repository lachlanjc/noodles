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
      f[0] = flash_type(f[0]) if f[1].present?
    end
  end

  def flash_type(level)
    case level.to_sym
    when :grey then nil
    when :success, :green then 'success'
    when :danger, :alert, :red then 'danger'
    when :notice, :info, :blue then 'notice'
    else 'notice'
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

  def current_location
    [params[:controller], params[:action]].join('#')
  end

  def flag_page?
    controllers = %w(pages subscriptions).include?(params[:controller])
    actions = %w(share).include?(params[:action])
    locations = %w(devise/registrations#edit).include?(current_location)
    !controllers && !actions && !locations
  end
end
