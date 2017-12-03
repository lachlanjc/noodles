require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should subscribe' do
    token = Stripe::Token.create(card: {
                                   number: 4_242_424_242_424_242,
                                   exp_month: Time.now.month,
                                   exp_year: Time.now.next_year.year,
                                   cvc: 314
                                 }).id
    assert_difference 'User.subscribers.count', +1 do
      post :create, params: { stripeToken: token }
      @user.reload
      assert_redirected_to subscriptions_url
    end
    assert @user.subscriber?
    assert_not_nil @user.stripe_customer
    assert_not_nil @user.stripe_subscription
    assert_not_nil @user.stripe_customer_details
    assert_not_nil @user.stripe_subscription_details
  end

  test 'should unsubscribe' do
    delete :destroy, params: { id: 'STRIPE_SUBSCRIPTION' }
    assert_redirected_to subscriptions_url
    @user.reload
    assert @user.free?
    assert_not @user.subscriber?
    assert_nil @user.stripe_customer
    assert_nil @user.stripe_subscription
  end
end
