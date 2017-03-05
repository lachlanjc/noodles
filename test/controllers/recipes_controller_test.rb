require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @recipe = recipes(:one)
  end

  teardown do
    Rails.cache.clear
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get show' do
    get :show, params: { id: @recipe.id }
    assert_response :success
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @recipe.id }
    assert_response :success
  end

  test 'should edit recipe' do
    put :update, params: { id: @recipe.id, recipe: { title: 'New title' } }
    assert_response :redirect
    @recipe.reload
    assert_equal 'New title', @recipe.title
    assert_not_empty flash[:success]
  end

  test 'should update collections' do
    put :update, params: { id: @recipe.id, recipe: { collections: [1] } }
    assert_response :redirect
    @recipe.reload
    assert_equal [1.to_s], @recipe.collections
    assert_nil flash[:success]
  end

  test 'should create recipe' do
    assert_difference('Recipe.count') do
      post :create, params: { recipe: { title: 'Some title' } }
    end
    assert_redirected_to recipe_path(Recipe.last)
    assert_not_empty flash[:success]
  end

  test 'should delete recipe' do
    assert_difference('Recipe.count', -1) do
      delete :destroy, params: { id: @recipe.id }
    end
    assert_redirected_to recipes_path
    assert_not_empty flash[:success]
  end

  test 'should get public' do
    get :share, params: { shared_id: @recipe.shared_id }
    assert_response :success
  end

  test 'should get collections' do
    get :collections, params: { id: @recipe.id }, xhr: true
    assert_response :success
  end

  test 'should get pdf' do
    get :export_pdf, params: { id: @recipe.id }
    assert_response :success
  end

  test 'should get embed' do
    get :embed_js, params: { shared_id: @recipe.shared_id }
    assert_response :success
  end

  test 'should remove image' do
    get :remove_image, params: { id: @recipe.id }
    @recipe.reload
    assert @recipe.unimaged?
    assert_redirected_to edit_recipe_url(@recipe)
  end

  test 'should get public page' do
    sign_out users(:one)
    get :share, params: { shared_id: @recipe.shared_id }
    assert_response :success
    sign_in users(:one)
  end

  test 'should be locked out' do
    sign_out users(:one)
    get :show, params: { id: @recipe.id }
    assert_response 403
    sign_in users(:one)
  end
end
