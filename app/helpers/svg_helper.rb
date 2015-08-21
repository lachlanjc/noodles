module SvgHelper
  def inline_svg(filename, options = {})
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    if options[:style].present?
      svg['style'] = options[:style]
    end
    doc.to_html.html_safe
  end

  def twitter_icon
    inline_svg("social-twitter.svg", { style: "fill: #00aced" })
  end
  end
end
