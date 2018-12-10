require 'test_helper'

class AnalyticsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test 'should be locked out' do
    get :dashboard
    assert_response 403
  end

  test 'should get dashboard' do
    sign_in users(:one)
    get :dashboard
    assert_response :success
  end

  test 'should get users list' do
    sign_in users(:one)
    get :all_users
    assert_response :success
  end
end
