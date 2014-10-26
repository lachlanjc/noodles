module TextHelper
  def cleaner(text, options = {})
    if options[:class].present?
      content_tag(:p, text, :class => "text #{options[:class]})")
    else
      content_tag(:p, text, :class => "text")
    end
  end

  def header_cleaner(header, options = {})
    if options[:class].present?
      content_tag(:h1, header, :class => "#{options[:class]}")
    else
      content_tag(:h1, header)
    end
  end

  def list_cleaner(text, options = {})
    if options[:class].present?
      simple_format(text, html_options = { :class => "text" })
    else
      simple_format(text)
    end
  end
end
