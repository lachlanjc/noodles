require 'test_helper'

class SaveControllerTest < ActionController::TestCase
  test 'should recognize invalid url' do
    get :save, params: { url: 'hello' }
    assert_not_empty flash[:danger]
  end

  test 'should prompt signup' do
    get :save, params: { url: 'http://cooking.nytimes.com/recipes/1016717-the-best-clam-chowder' }
    assert_response 302
  end

  test 'should successfully save' do
    sign_in users(:one)
    get :save, params: { url: 'http://cooking.nytimes.com/recipes/1016717-the-best-clam-chowder' }
    assert_response 302
    assert_not_nil flash[:success]
  end
end
