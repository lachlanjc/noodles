class HelpController < ApplicationController
  def index
    render "help"
  end

  def favorites
    render "favorites"
  end
end
