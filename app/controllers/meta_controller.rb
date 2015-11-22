class MetaController < ApplicationController
  include NavHelper
  include TextHelper

  def home
    @primary_link = user_signed_in? ? recipes_path : explore_path
    @primary_text = user_signed_in? ? 'Your recipes →' : 'Start Exploring'
    render :home, layout: false
  end

  def about
  end

  def styleguide
  end

  def terms
    render_doc 'terms.md'
  end

  def privacy
    render_doc 'privacy.md'
  end

  def docs
    render_doc 'docs.md'
  end

  protected

  def render_doc(filename)
    @title = filename.chomp('.md').humanize
    activate_nav! filename.chomp('.md')
    @doc = markdown(File.read(Rails.root.join('public', 'docs', filename))).html_safe
    render :doc
  end
end
