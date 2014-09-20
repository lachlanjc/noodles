module ApplicationHelper
  def flash_class(level)
    case level.to_sym
      when :notice then "notification-info"
      when :success then "notification-success"
      when :error then "notification-danger"
      when :alert then "notification-danger"
      when :view then "notification-info"
    end
  end

  def flash_icon_class(level)
    case level.to_sym
      when :notice then "geomicon-info"
      when :success then "geomicon-check"
      when :error then "geomicon-alert"
      when :alert then "geomicon-alert"
      when :view then "geomicon-view"
    end
  end
end
