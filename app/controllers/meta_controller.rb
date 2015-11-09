class MetaController < ApplicationController
  include MetaHelper

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
end
