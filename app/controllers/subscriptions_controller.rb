class SubscriptionsController < ApplicationController
  require 'stripe'

  before_action :please_sign_in

  def index
    @subscription = current_user.stripe_subscription_details
  end

  def create
    current_user.subscribe!(params[:stripeToken])
    EmailMeJob.perform_later(
      subject: "New subscriber! #{Time.now.to_s(:short)}",
      body: "#{current_user.first_name} (#{current_user.email}) just subscribed. 🎉"
    )
    redirect_to subscriptions_url
  end

  def destroy
    current_user.unsubscribe!
    flash[:success] = 'Successfully unsubscribed.'
    redirect_to subscriptions_url
  end
end
