class AnalyticsController < ApplicationController
  before_action :authenticate

  def dashboard
    @users = User.all.count
    @users_none = User.left_outer_joins(:recipes).where(recipes: { id: nil }).count
    @users_week = User.where('created_at > ?', 1.week.ago).count
    @users_active = User.where('last_sign_in_at > ?', 1.week.ago).count
    @subscribers = User.subscribers
    @subscribers_week = @subscribers.where('subscribed_at > ?', 1.week.ago).count
    @subscribers = @subscribers.count
  end

  def all_users
    @users = User.all.order(created_at: :desc)
  end

  def performance
    @cohorts = CohortMe.analyze(period: 'weeks', activation_class: Recipe)
  end

  private

  def authenticate
    a = user_signed_in? && current_user.id == 1
    render_locked(OpenStruct.new(type: 'page')) unless a
  end
end
