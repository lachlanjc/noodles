require 'test_helper'

class ExploreControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test 'should get index' do
    sign_in users(:one)
    get :index
    assert_response :success
  end

  test 'should get nyt results' do
    get :results, params: { src: 'nyt', q: 'pancakes' }
    assert_response :success
    assert_not_empty assigns(:results)
  end

  test 'should get epicurious results' do
    get :results, params: { src: 'epicurious', q: 'pancakes' }
    assert_response :success
    assert_not_empty assigns(:results)
  end

  test 'should get allrecipes results' do
    get :results, params: { src: 'allrecipes', q: 'pancakes' }
    assert_response :success
    assert_not_empty assigns(:results)
  end

  test 'should get nyt preview' do
    get :preview, params: { url: 'http://cooking.nytimes.com/recipes/1012732-bacon-lettuce-and-plum-sandwiches' }
    assert_response :success
    r = assigns(:recipe)
    assert_not_nil r
    assert_match 'plums', r.ingredients
    assert_match 'cutting board', r.instructions
    assert_equal '2 servings', r.serves
  end

  test 'should get epicurious preview' do
    get :preview, params: { url: 'https://www.epicurious.com/recipes/food/views/sheet-pan-grilled-cheese-56390006' }
    assert_response :success
    r = assigns(:recipe)
    assert_not_nil r
    assert_match 'bread', r.ingredients
    assert_match 'baking sheet', r.instructions
    assert_equal '6 servings', r.serves
  end

  test 'should get allrecipes preview' do
    get :preview, params: { url: 'http://allrecipes.com/recipe/18433/irresistible-pecan-pie' }
    assert_response :success
    r = assigns(:recipe)
    assert_not_nil r
    assert_match 'white sugar', r.ingredients
    assert_match 'Preheat', r.instructions
    assert_equal '12', r.serves
  end
end
