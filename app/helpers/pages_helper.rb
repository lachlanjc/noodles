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

  def bg_carousel(url = basic_carousel_url)
    content_for(:bg_img) { image_path url }
  end

  def style_carousel(url)
    "background-image: url(#{image_path url});"
  end

  def home_carousel_url
    "home/#{rand(1..5)}.jpg"
  end

  def explore_carousel_url
    "explore/#{rand(1..5)}.jpg"
  end

  def basic_carousel_url
    "carousel/#{rand(1..6)}.jpg"
  end
end
