class HelpController < ApplicationController
  def index
  end

  def favorites
  end

  def terms
    @doc = md_file('terms.md')
  end

  def privacy
    @doc = md_file('privacy.md')
  end

  private
    def md_file(name)
      file_contents = File.open(Rails.root + 'public/docs/' + name.to_s).read
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, underline: true, space_after_headers: true, strikethrough: true)
      document = markdown.render(file_contents)
      return document.html_safe
    end
end
