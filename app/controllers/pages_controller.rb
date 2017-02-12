class PagesController < ApplicationController
  include NavHelper
  include TextHelper

  def home
    @hide_flash = true
    render :home, layout: false
  end

  def help
  end

  def styleguide
    render :styleguide, layout: 'simple'
  end

  def terms
    render_doc :terms
  end

  def privacy
    render_doc :privacy
  end

  def embed_demo
    render 'embed_demo', layout: false
  end

  private

  def render_doc(filename)
    activate_nav! filename.to_s.chomp('.md').to_sym
    @title = filename.to_s.chomp('.md').humanize
    data = File.read(Rails.root.join('public', 'docs', filename.to_s + '.md'))
    @doc = markdown(data).html_safe
    render 'pages/doc', layout: 'simple'
  end
end
