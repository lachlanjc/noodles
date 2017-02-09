require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test 'home page' do
    get :home
    assert_response :success
  end

  test 'help page' do
    get :help
    assert_response :success
  end

  test 'terms page' do
    get :terms
    assert_response :success
  end

  test 'privacy page' do
    get :privacy
    assert_response :success
  end
end
