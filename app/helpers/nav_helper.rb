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

  def flash_color_class(level)
    case level.to_sym
    when :grey then 'grey-3'
    when :green then 'green'
    when :red, :alert then 'red'
    when :blue, :notice then 'blue'
    else 'grey-3'
    end
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def remove_grey_bg!
    content_for(:body_classes) { nil }
  end

  def body_classes
    if content_for?(:bg_img)
      'bg-no-repeat bg-center bg-cover'
    else
      content_for(:body_classes) || 'bg-grey-5'
    end
  end

end
