module PagesHelper
  def feature_list_item(name, description, link = nil)
    content_tag(link ? :a : :div, href: link, rel: link && 'nofollow', class: 'feature-list__item flex-grid__item') do
      [
        link ? content_tag(:span, '↗', class: 'blue b fr') : nil,
        content_tag(:h3, name, class: 'mtn mbs'),
        content_tag(:p, description, class: 'man grey-3')
      ].join.html_safe
    end
  end
end
