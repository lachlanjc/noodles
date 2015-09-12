require 'test_helper'

class ExploreControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'should get index' do
    sign_in users(:one)
    get :index
    assert_response :success
  end

  test 'should get nyt results' do
    get :results, { src: 'nyt', q: 'pancakes' }
    assert_response :success
    assert_not_nil assigns(:results)
  end

  test 'should get epicurious results' do
    get :results, { src: 'epicurious', q: 'pancakes' }
    assert_response :success
    assert_not_nil assigns(:results)
  end

  test 'should get nyt preview' do
    get :preview, { url: 'http://cooking.nytimes.com/recipes/1012732-bacon-lettuce-and-plum-sandwiches' }
    assert_response :success
    assert_not_nil assigns(:recipe)
  end

  test 'should get epicurious preview' do
    get :preview, { url: 'http://www.epicurious.com/recipes/food/views/sheet-pan-grilled-cheese-56390006' }
    assert_response :success
    assert_not_nil assigns(:recipe)
  end
end
