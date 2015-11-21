module TextHelper
  def markdown(str = '')
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, underline: true, space_after_headers: true, strikethrough: true).render(str).html_safe
  end

  def plain_text_from_markdown(text = '')
    sanitize strip_tags(markdown(text.to_s))
  end

  def whitened_markdown(str = '', options = [])
    classes = 'white'
    classes << ' f3' if options.include? :f3
    text = Nokogiri::HTML::DocumentFragment.parse(sanitize(markdown(str)))
    text.css('p').each { |item| item['class'] = classes }
    text.to_s.html_safe
  end

  def remove_url_head(url)
    url.gsub(/^http(s?):\/\/(w+\.)?/, '')
  end

  def clean_autolink(text)
    auto_link(text, html: { target: '_blank' }) { |text| remove_url_head(text) }
  end

  def format_date(time)
    time.strftime("%B %-e, %Y")
  end

  def format_time(time)
    time.strftime("%l").strip << time.strftime(":%M") << time.strftime("%p").downcase
  end
end
