module MetaHelper
  include MarkdownHelper

  def render_doc(filename)
    @title = filename.chomp('.md').humanize
    @nav = filename.chomp('.md').to_sym
    @doc = markdown(File.read(Rails.root.join('public', 'docs', filename))).html_safe
    render 'pages/doc'
  end
end
