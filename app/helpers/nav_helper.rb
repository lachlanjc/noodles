module NavHelper
  def nav_active_class(nav)
    if nav_active?(nav)
      return "px1 bold"
    else
      return "px1"
    end
  end

  def nav_active?(nav)
    @navs ||= []
    @navs.include?(nav.to_sym)
  end

  def activate_nav!(nav)
    @navs ||= []
    @navs.push(nav.to_sym)
  end
end
