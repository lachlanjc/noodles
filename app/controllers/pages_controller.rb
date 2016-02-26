class PagesController < ApplicationController
  include PagesHelper

  before_filter :home_setup, only: [:home, :home_forced]

  def home
    render :home, layout: false
  end

  def home_forced
    render :home, layout: false
  end

  def about
  end

  def styleguide
  end

  def terms
    render_doc('terms.md')
  end

  def privacy
    render_doc('privacy.md')
  end

  def docs
    render_doc('docs.md')
  end

  def embed_demo
    render 'embed_demo', layout: false
  end

  private

  def home_setup
    @primary_link = user_signed_in? ? recipes_path : explore_path
    @primary_text = user_signed_in? ? 'Your recipes →' : 'Start Exploring'
  end
end
