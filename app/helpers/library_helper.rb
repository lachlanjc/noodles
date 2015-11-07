module LibraryHelper
  def me_owns_page?
    user_signed_in? && @page.user_id == current_user.id
  end

  def not_my_page?
    !me_owns_page?
  end

  def page_title(page = @page)
    @page.name.present? ? @page.name.to_s.html_safe : 'New page'
  end
end
