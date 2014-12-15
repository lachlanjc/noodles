module ApplicationHelper
  def flash_class(level)
    case level.to_sym
      when :info then 'flash-info'
      when :success then 'flash-success'
      when :danger then 'flash-danger'
      when :view then 'flash-danger'
    end
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def is_admin?
    if current_user && (current_user.id == 1 || current_user.id == 23)
      return true
    else
      return false
    end
  end

  def authenticate
    if current_user && (current_user.id == 1 || current_user.id == 23)
      @access = true
    else
      @access = false
      flash[:danger] = 'Sorry, you can\'t look at that page.'
      redirect_to root_url
    end
  end

end
