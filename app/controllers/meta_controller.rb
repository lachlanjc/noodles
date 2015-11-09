class MetaController < ApplicationController
  include MetaHelper

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
    render_doc 'terms.md'
  end

  def privacy
    render_doc 'privacy.md'
  end

  def docs
    render_doc 'docs.md'
  end
end
