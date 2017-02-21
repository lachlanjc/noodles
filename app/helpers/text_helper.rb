module TextHelper
  def markdown(str = '')
    opts = { autolink: true, underline: true, highlight: true, strikethrough: true }
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, opts).render(str.to_s)
    ActionController::Base.helpers.sanitize md.html_safe
  end

  def plain_text_from_markdown(text = '', options = {})
    text = sanitize(markdown(text), tags: %w(ol ul li))
    text = HtmlToPlainText.plain_text(text)
    text.gsub!(/^\d+\.\s/, '') if options[:remove_numbers]
    text
  end

  def whitened_markdown(str = '', options = [])
    classes = 'white'
    classes << ' f3' if options.include? :f3
    text = Nokogiri::HTML::DocumentFragment.parse(sanitize(markdown(str)))
    text.css('p').each { |item| item['class'] = classes }
    text.to_s.html_safe
  end

  def remove_url_head(url)
    url.gsub /^http(s?):\/\/(w+\.)?/, ''
  end

  def strip_whitespace(str = '')
    str.gsub(/\n|\s\s+/, '').strip
  end

  def clean_autolink(text)
    node = Nokogiri::HTML::DocumentFragment.parse(markdown(text)).css('a')[0]
    node[:target] = '_blank'
    node.content = remove_url_head(text)
    node.to_s.html_safe
  end

  def section_header(text, level, options = {})
    tag = "h#{level}"
    options[:class] = ['section-header', options[:class]].join(' ')
    content_tag(tag, options) do
      content_tag(:span, text, class: 'section-header__name')
    end
  end
end
