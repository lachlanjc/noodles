class AnalyticsController < ApplicationController
  before_action :authenticate

  def dashboard
    @users = User.all.count
    @users_none = User.left_outer_joins(:recipes).where(recipes: { id: nil }).count
    @users_many = @users - @users_none
    @users_week = User.where('created_at > ?', 1.week.ago).count
    @users_active = User.where('last_sign_in_at > ? OR current_sign_in_at IS NOT NULL', 1.week.ago).count
    @subscribers = User.where('subscribed_at IS NOT NULL')
    @subscribers_week = @subscribers.where('subscribed_at < ?', 1.week.ago).count
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
    accessible = user_signed_in? && current_user.id == 1
    render_locked(OpenStruct.new(type: 'private page')) unless accessible
  end
end
