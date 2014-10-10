module ApplicationHelper
  def flash_class(level)
    case level.to_sym
      when :notice then "flash-info"
      when :success then "flash-success"
      when :error then "flash-danger"
      when :alert then "flash-danger"
      when :view then "flash-danger"
    end
  end
end
