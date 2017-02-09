class AnalyticsController < ApplicationController
  before_filter :authenticate

  def dashboard
    @users_count = 0
    @users_none = []
    @users_many = []
    @users_week = []
    @users_active = []

    User.find_each do |user|
      count = user.recipes.count
      @users_none.push(user) if count == 0 || count == 1
      @users_many.push(user) if count > 1
      @users_week.push(user) if user.created_at < 1.week.ago
      @users_active.push(user) if user.last_sign_in_at < 1.week.ago
      @users_count += 1
    end
  end

  def all_users
    @users = User.all.order(created_at: :desc)
  end

  def performance
    @cohorts = CohortMe.analyze(period: 'weeks', activation_class: Recipe)
  end

  private

  def authenticate
    accessible = user_signed_in? && current_user.id == 1
    render_locked(OpenStruct.new({ type: 'analytic' })) unless accessible
  end
end
