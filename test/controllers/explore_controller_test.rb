require 'test_helper'

class ExploreControllerTest < ActionController::TestCase
  test 'should get index' do
    sign_in users(:one)
    get :index
    assert_response :success
  end

  test 'should get nyt results' do
    get :results, params: { src: 'nyt', q: 'pancakes' }
    assert_response :success
    assert_not_nil assigns(:results)
  end

  test 'should get epicurious results' do
    get :results, params: { src: 'epicurious', q: 'pancakes' }
    assert_response :success
    assert_not_nil assigns(:results)
  end

  test 'should get allrecipes results' do
    get :results, params: { src: 'allrecipes', q: 'pancakes' }
    assert_response :success
    assert_not_nil assigns(:results)
  end

  test 'should get nyt preview' do
    get :preview, params: { url: 'http://cooking.nytimes.com/recipes/1012732-bacon-lettuce-and-plum-sandwiches' }
    assert_response :success
    assert_not_nil assigns(:recipe)
  end

  test 'should get epicurious preview' do
    get :preview, params: { url: 'https://www.epicurious.com/recipes/food/views/sheet-pan-grilled-cheese-56390006' }
    assert_response :success
    assert_not_nil assigns(:recipe)
  end

  test 'should get allrecipes preview' do
    get :preview, params: { url: 'http://allrecipes.com/recipe/206086/rice-pancakes/' }
    assert_response :success
    assert_not_nil assigns(:recipe)
  end
end
