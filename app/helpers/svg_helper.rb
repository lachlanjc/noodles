module SvgHelper
  def inline_svg(path, options = {})
    file = File.open("app/assets/images/#{path}", "rb")
    svg = raw file.read
    if options[:class].present?
      svg["class"] = options[:class]
    end
    return svg
  end
end
