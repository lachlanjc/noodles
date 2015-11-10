module LibraryHelper
  include ApplicationHelper

  def me_owns_page?
    user_signed_in? && @page.user_id == current_user.id
  end

  def not_my_page?
    !me_owns_page?
  end

  def page_title(page = @page, text = 'Untitled')
    page.name.present? ? page.name.to_s : text.to_s
  end

  def page_preview_text(text)
    text = text.to_s.gsub('<li>', '• ').gsub('</li>', '<br>')
    text = Sanitize.fragment text, elements: %w(strong del br blockquote pre)
    text.html_safe
  end

  def shared_page_path(page = @page)
    "/p/#{page.shared_id.to_s}"
  end

  def shared_page_url(page = @page)
    app_url + shared_page_path(page)
  end
end
