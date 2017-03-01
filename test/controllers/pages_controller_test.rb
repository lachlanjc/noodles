require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test 'should get home page' do
    get :home
    assert_response :success
  end

  test 'should get help page' do
    get :help
    assert_response :success
  end

  test 'should get terms page' do
    get :terms
    assert_response :success
  end

  test 'should get privacy page' do
    get :privacy
    assert_response :success
  end
end
