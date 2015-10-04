require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @recipe = recipes(:one)
    @recipe.user_id = users(:one).id
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

  test 'cannot save without title' do
    post :create, recipe: { title: nil }
    assert_not recipe.save
  end

  test 'should create recipe' do
    assert_difference('Recipe.count') do
      post :create, recipe: {
        title: @recipe.title, id: 1, description: @recipe.description,
        ingredients: @recipe.ingredients, instructions: @recipe.instructions
      }
    end

    assert_redirected_to recipe_path(assigns(:recipe))
    assert_equal 'Awesome, you\'ve saved your new recipe.', flash[:green]
  end

  test 'should show recipe' do
    get :show, id: @recipe.id.to_s
    assert_template 'recipes/show'
    assert_response :success
  end

  test 'should show locked recipe page' do
    sign_out users(:one)
    get :show, id: @recipe.id.to_s
    assert_template :locked
    assert_response 403
  end

  test 'should get edit' do
    get :edit, id: @recipe.id.to_s
    assert_response :success
  end

  test 'should update recipe' do
    patch :update, id: @recipe, recipe: {
      title: @recipe.title, id: 1, description: @recipe.description,
      ingredients: @recipe.ingredients, instructions: @recipe.instructions
    }
    assert_redirected_to recipe_path(assigns(:recipe))
    assert_equal 'Great, your changes were saved.', flash[:green]
  end

  test 'should destroy recipe' do
    assert_difference('Recipe.count', -1) do
      delete :destroy, id: @recipe
    end

    assert_redirected_to recipes_path
  end

  test 'should get recipe pdf' do
    get :export_pdf, recipe_id: @recipe.id.to_s
    assert_not_nil assigns(:recipe)
    assert_response :success
  end

  test 'should share recipe' do
    get :share_this_recipe, recipe_id: @recipe.id.to_s
    assert_equal @recipe.user_id, users(:one).id
    assert_not_nil assigns(:recipe)
    assert_redirected_to share_path(assigns(:recipe).shared_id)
    assert assigns(:recipe).shared
  end

  test 'should show shared recipe' do
    get :share, shared_id: @recipe.shared_id.to_s
    assert_not_nil assigns(:recipe)
    assert_response :success
  end

  test 'should unshare recipe' do
    get :un_share, id: @recipe.id.to_s
    assert_redirected_to recipe_path(assigns(:recipe))
    assert_equal false, assigns(:recipe)
    assert_not_nil flash[:grey]
  end
end
