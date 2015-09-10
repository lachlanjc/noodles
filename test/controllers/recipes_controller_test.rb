require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    sign_in users(:one)
    @recipe = recipes(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipes)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create recipe' do
    assert_difference('Recipe.count') do
      post :create, recipe: { title: @recipe.title, id: 1, description: @recipe.description, ingredients: @recipe.ingredients, instructions: @recipe.instructions }
    end

    assert_redirected_to recipe_path(assigns(:recipe))
    assert_equal 'Awesome, you\'ve saved your new recipe.', flash[:green]
  end

  test 'should show recipe' do
    get :show, id: @recipe
    assert_template 'recipes/show'
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @recipe
    assert_response :success
  end

  test 'should update recipe' do
    patch :update, id: @recipe, recipe: { description: @recipe.description, ingredients: @recipe.ingredients, instructions: @recipe.instructions, title: @recipe.title }
    assert_redirected_to recipe_path(assigns(:recipe))
    assert_equal 'Great, your changes were saved.', flash[:green]
  end

  test 'should destroy recipe' do
    assert_difference('Recipe.count', -1) do
      delete :destroy, id: @recipe
    end

    assert_redirected_to recipes_path
  end
end
