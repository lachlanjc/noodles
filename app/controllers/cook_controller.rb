class CookController < ApplicationController
  before_action :set_recipe

  def index
    if isnt_my?(@recipe) && params[:shared_id].blank?
      render_locked @recipe
    else
      @exit_path = make_exit_path
      render :index
    end
  end

  def record_cook
    please_sign_in
    hey_thats_my @recipe
    @recipe.increment :cooks_count
    @recipe.update_attribute(:last_cooked_at, Time.now)
    head :ok
  end

  private

  def set_recipe
    @recipe = Recipe.includes(:user).find_by regular_or_shared_id
    raise_not_found
  end

  def raise_not_found
    raise ActiveRecord::RecordNotFound if @recipe.nil?
  end

  def make_exit_path
    if @recipe.sample?
      root_url
    elsif is_my? @recipe
      recipe_path @recipe
    else
      share_path @recipe.shared_id
    end
  end
end
