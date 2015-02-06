class AnalyticsController < ApplicationController
  before_filter :authenticate

  def dashboard
    @recipes_count = Recipe.all.count
    @recipes_shared_count = Recipe.where(:shared => true).count

    @users_with_one, @users_with_many, @users_with_none = []

    User.all.order(created_at: :desc).each do |user|
      @user_recipe_count = Recipe.where(:user_id => user.id).count
      @users_with_none.push(user) if @user_recipe_count == 0
      @users_with_one.push(user)  if @user_recipe_count == 1
      @users_with_many.push(user) if @user_recipe_count > 1
    end
  end

  def shared_recipes
    @recipes = Recipe.where(:shared => true).order(created_at: :desc)
  end

  def all_users
    @users = User.all.order(created_at: :desc)
  end

  def performance
    @cohorts = CohortMe.analyze(period: "weeks",
    activation_class: Recipe)
  end

  def marketable
    @users = User.all.order(created_at: :desc)
  end

  private
    def authenticate
      redirect_to root_url unless current_user && (current_user.id == 1 || current_user.id == 23)
    end
end
