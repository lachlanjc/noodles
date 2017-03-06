require 'test_helper'

class SaveControllerTest < ActionController::TestCase
  test 'should prompt signup' do
    get :save, params: { url: 'http://cooking.nytimes.com/recipes/1016717-the-best-clam-chowder' }
    assert_redirected_to new_user_registration_url
    assert_not_nil flash[:notice]
  end

  test 'should save new recipe' do
    sign_in users(:one)
    assert_difference 'Recipe.count', +1 do
      get :save, params: { url: 'http://cooking.nytimes.com/recipes/1016717-the-best-clam-chowder' }
    end
    assert_redirected_to recipe_path(Recipe.last)
    assert_not_empty flash[:success]
  end

  test 'should recognize invalid url' do
    get :save, params: { url: 'hello' }
    assert_response :redirect
    assert_not_empty flash[:danger]
  end
end
