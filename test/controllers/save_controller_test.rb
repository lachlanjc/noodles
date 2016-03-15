require 'test_helper'

class SaveControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should recognize invalid url' do
    get :save, url: 'hello'
    assert_response :success
  end

  test 'should prompt signup' do
    get :save, url: 'http://cooking.nytimes.com/recipes/1016717-the-best-clam-chowder'
    assert_response :success
  end

  test 'should successfully save' do
    sign_in users(:one)
    get :save, url: 'http://cooking.nytimes.com/recipes/1016717-the-best-clam-chowder'
    assert_response 302
    assert_not_nil flash[:green]
  end
end
