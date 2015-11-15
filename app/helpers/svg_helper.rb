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
      options[:style] += "fill: ##{options[:fill].to_s};"
      options.delete :fill
    end
    options.each { |key, value| svg["#{key}"] = value }
    doc.to_html.html_safe
  end

  def twitter_icon
    inline_svg 'social-twitter.svg', fill: '00aced'
  end

  def facebook_icon
    inline_svg 'social-facebook.svg', fill: '3b5998'
  end

  def pinterest_icon
    inline_svg 'social-pinterest.svg', fill: 'cb2027'
  end

  def buffer_icon
    inline_svg 'social-buffer.svg', fill: '555'
  end

  def googleplus_icon
    inline_svg 'social-google-plus.svg', fill: 'dc4e41'
  end

  def email_icon
    inline_svg 'social-email.svg', fill: '0092ff'
  end
end
