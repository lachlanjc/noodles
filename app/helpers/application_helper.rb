module ApplicationHelper
  def simple_controller
    request.filtered_parameters['controller']
  end

  def simple_action
    request.filtered_parameters['action']
  end

  def modal_close
    content_tag :action,
      react_component('Icon', { glyph: 'view-close', size: 36 }, { class: 'grey-3' }),
      class: 'fr dib lh pointer', data: { behavior: 'modal_close' }
  end

  def modal_header(text)
    html = modal_close
    html << content_tag(:h2, text, class: 'mtn')
    html << tag(:hr, class: 'mtn')
    html
  end

  def backlink(label, path)
    arrow = content_tag(:span, '← ', class: 'grey-2')
    link = link_to("Back to #{label}", path, class: 'blue')
    content_tag(:section, arrow + link, class: 'pvs tc f5').html_safe
  end

  def make_schema(data = {})
    content_tag 'script', data.to_json.html_safe, type: 'application/ld+json'
  end

  def org_schema
    {
      '@context': 'http://schema.org',
      '@type': 'Organization',
      name: 'Noodles',
      url: 'https://getnoodl.es',
      logo: image_url('icon/circle@512.png'),
      sameAs: [
        'https://news.getnoodl.es',
        'https://twitter.com/noodlesapp',
        'https://facebook.com/getnoodles'
      ],
      contactPoint: [{
        '@type': 'ContactPoint',
        email: 'lachlan@getnoodl.es',
        contactType: 'customer support inquiries',
        url: 'https://getnoodl.es/help'
      }]
    }
  end
end
