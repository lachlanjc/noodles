module SvgHelper
  def inline_svg(filename, options = {})
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    options[:style] = options[:style] || ''
    if options[:size]
      options[:width] = options[:size]
      options[:height] = options[:size]
      options.delete :size
    end
    if options[:fill]
      options[:style] += "fill: ##{options[:fill]};"
      options.delete :fill
    end
    options.each { |key, value| svg["#{key}"] = value }
    doc.to_html.html_safe
  end

  def inline_svg_path(filename)
    Nokogiri::HTML(inline_svg(filename)).xpath('//path/@d')
  end

  def social_icon(service = 'email')
    colors = {
      twitter: '00aced',
      facebook: '3b5998',
      pinterest: 'cb2027',
      buffer: '555',
      gplus: 'dc4e41',
      email: '0092ff'
    }
    inline_svg "social-#{service}.svg", fill: colors[service.to_sym]
  end
end
