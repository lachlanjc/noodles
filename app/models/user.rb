class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # :marketable

  has_many :recipes, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :groceries, dependent: :destroy

  validates :phone, uniqueness: true, allow_blank: true

  scope :subscribers, -> { where('subscribed_at IS NOT NULL') }

  =begin
  after_update :update_stripe_customer!
  before_destroy :delete_stripe_data!

  STRIPE_PLAN_ID = 'noodles-subscription'.freeze

  def create_stripe_customer!(stripe_token)
    return stripe_customer_details if stripe_customer.present?
    customer = Stripe::Customer.create(
      source: stripe_token,
      email: email,
      description: first_name,
      metadata: {
        user_id: id
      }
    )
    update(stripe_customer: customer.id)
    customer
  end

  def update_stripe_customer!
    return if stripe_customer.blank?
    customer = stripe_customer_details
    customer.description = first_name
    customer.email = email
    customer.save
  end

  def subscribe!(stripe_token)
    customer = create_stripe_customer!(stripe_token)
    subscription = Stripe::Subscription.create(
      customer: customer.id,
      plan: Stripe::Plan.retrieve(STRIPE_PLAN_ID)
    )
    update(
      subscribed_at: Time.now,
      stripe_subscription: subscription.id
    )
  end

  def unsubscribe!
    delete_stripe_subscription!
    update(subscribed_at: nil, stripe_subscription: nil)
  end

  def stripe_customer_details
    return {} if stripe_customer.blank?
    Stripe::Customer.retrieve(stripe_customer)
  end

  def delete_stripe_customer!
    return if stripe_customer.blank?
    stripe_customer_details.delete
  end

  def stripe_subscription_details
    return {} if stripe_subscription.blank?
    Stripe::Subscription.retrieve(stripe_subscription)
  end

  def delete_stripe_subscription!
    return if stripe_subscription.blank?
    stripe_subscription_details.delete
  end

  def delete_stripe_data!
    delete_stripe_customer! && delete_stripe_subscription!
    update(subscribed_at: nil, stripe_customer: nil, stripe_subscription: nil)
  end
  =end

  def subscriber?
    subscribed_at.present?
  end

  def free?
    !subscriber?
  end
end
