class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # :marketable

  has_many :recipes, dependent: :destroy
  has_many :collections, dependent: :destroy

  after_update :update_stripe_customer!
  before_destroy :delete_stripe_data!

  scope :subscribers, -> { where('subscribed_at IS NOT NULL') }

  STRIPE_PLAN_ID = 'noodles-subscription'

  def create_stripe_customer!(stripe_token)
    return self.stripe_customer_details if self.stripe_customer.present?
    customer = Stripe::Customer.create(
      source: stripe_token,
      email: self.email,
      description: self.first_name,
      metadata: {
        user_id: self.id
      }
    )
    self.update(stripe_customer: customer.id)
    customer
  end

  def update_stripe_customer!
    return if self.stripe_customer.blank?
    customer = self.stripe_customer_details
    customer.description = self.first_name
    customer.email = self.email
    customer.save
  end

  def subscribe!(stripe_token)
    customer = self.create_stripe_customer!(stripe_token)
    subscription = Stripe::Subscription.create(
      customer: customer.id,
      plan: Stripe::Plan.retrieve(STRIPE_PLAN_ID)
    )
    self.update(
      subscribed_at: Time.now,
      stripe_subscription: subscription.id
    )
  end

  def unsubscribe!
    self.delete_stripe_subscription!
    self.update(subscribed_at: nil, stripe_subscription: nil)
  end

  def stripe_customer_details
    return if self.stripe_customer.blank?
    Stripe::Customer.retrieve(self.stripe_customer)
  end

  def delete_stripe_customer!
    return if self.stripe_customer.blank?
    self.stripe_customer_details.delete
  end

  def stripe_subscription_details
    return if self.stripe_subscription.blank?
    Stripe::Subscription.retrieve(self.stripe_subscription)
  end

  def delete_stripe_subscription!
    return if self.stripe_subscription.blank?
    self.stripe_subscription_details.delete
  end

  def delete_stripe_data!
    self.delete_stripe_customer! && self.delete_stripe_subscription!
    self.update(subscribed_at: nil, stripe_customer: nil, stripe_subscription: nil)
  end

  def subscriber?
    subscribed_at.present?
  end

  def free?
    !subscriber?
  end
end
