class AnalyticsController < ApplicationController
  before_filter :authenticate

  def dashboard
    @users_count = User.all.count
    @users_none = []
    @users_one = []
    @users_many = []

    User.all.each do |user|
      @count = user.recipes.count
      @users_none.push(user) if @count == 0
      @users_one.push(user)  if @count == 1
      @users_many.push(user) if @count > 1
    end
  end

  def all_users
    @users = User.all.order(created_at: :desc)
  end

  def collections
    @collections = Collection.all.order(created_at: :desc)
  end

  def performance
    @cohorts = CohortMe.analyze(period: 'weeks', activation_class: Recipe)
  end

  private

  def authenticate
    redirect_to root_url unless user_signed_in? && current_user.id == 1
  end
end
