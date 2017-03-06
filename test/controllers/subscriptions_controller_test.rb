require 'test_helper'

# This is actually an integration test ¯\_(ツ)_/¯
class SubscriptionsControllerTest < ActionController::TestCase
  test 'should get index' do
    sign_in users(:one)
    get :index
    assert_response :success
  end

  test 'should subscribe' do
    sign_in users(:one)
    current_user = @controller.current_user
    token = StripeMock.create_test_helper.generate_card_token
    assert_difference 'User.subscribers.count', +1 do
      post :create, params: { stripeToken: token }
    end
    assert_redirected_to subscriptions_url
    assert current_user.subscriber?
    assert_not_nil current_user.stripe_customer
    assert_not_nil current_user.stripe_subscription
    assert_not_nil current_user.stripe_customer_details
    assert_not_nil current_user.stripe_subscription_details
  end

  test 'should unsubscribe' do
    sign_in users(:one)
    current_user = @controller.current_user
    delete :destroy, params: { id: 'STRIPE_SUBSCRIPTION' }
    assert_redirected_to subscriptions_url
    assert current_user.free?
    assert_not current_user.subscriber?
    assert_nil current_user.stripe_customer
    assert_nil current_user.stripe_subscription
  end
end
