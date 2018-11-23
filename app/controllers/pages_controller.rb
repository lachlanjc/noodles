class PagesController < ApplicationController
  include NavHelper
  include TextHelper

  caches_page :home, :styleguide, :terms, :privacy

  def home
    render :home, layout: false
  end

  def help
    render :help
  end

  def help_form
    m = params[:message].to_s
    x = ['porn', 'viagra', 'drive.google.com', '.ru', 'casino']
    if m.length > 16 && !x.any? { |s| m.include? s }
      HelpFormJob.perform_later(email: params[:email], message: m, url: request.referer)
      flash[:success] = 'Thanks—message sent!'
    end
    request.referer == root_url ? redirect_to(help_url) : go_back
  end

  def styleguide
    render :styleguide
  end

  def terms
    render_doc :terms
  end

  def privacy
    render_doc :privacy
  end

  def embed_demo
    render :embed_demo, layout: false
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
