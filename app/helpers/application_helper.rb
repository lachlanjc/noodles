module ApplicationHelper
  include DeviseHelper

  def flash_color_class(level)
    case level.to_sym
    when :grey then 'grey-3'
    when :green then 'green'
    when :red, :alert then 'red'
    when :blue, :notice then 'blue'
    else 'grey-3'
    end
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def app_url
    Rails.env.development? ? 'http://noodles.dev' : 'https://getnoodl.es'
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
