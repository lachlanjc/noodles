module SvgHelper
  def inline_svg(filename, options = {})
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    options[:style] ||= ''
    if options[:size]
      options[:width] = options[:size]
      options[:height] = options[:size]
      options.delete :size
    end
    options.each { |key, value| svg[key.to_s] = value }
    doc.to_html.html_safe
  end

  def inline_svg_path(filename)
    Nokogiri::HTML(inline_svg(filename)).xpath('//path/@d')
  end
end
