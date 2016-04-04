module ApplicationHelper
  def app_url
    Rails.env.development? ? 'http://noodles.dev' : 'https://getnoodl.es'
  end

  def simple_controller
    request.filtered_parameters['controller']
  end

  def simple_action
    request.filtered_parameters['action']
  end

  def modal_close
    svg = inline_svg('close.svg', class: 'fill-grey-4')
    content_tag :action, svg, class: 'db fr pointer', data: { behavior: 'modal_close' }
  end

  def modal_header(text)
    html = modal_close
    html << content_tag(:h2, text, class: 'mtn tl')
    html << tag(:hr)
    html
  end
end
