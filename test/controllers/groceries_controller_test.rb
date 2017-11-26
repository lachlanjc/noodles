require 'test_helper'

class GroceriesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    sign_in users(:one)
    @grocery = groceries(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create grocery' do
    assert_difference('Grocery.count') do
      post :create, params: { grocery: { name: @grocery.name, user_id: @grocery.user_id } }
    end
    assert_equal @grocery.name, Grocery.last.name

    assert_response :redirect
  end

  test 'should update grocery' do
    @name = groceries(:two).name
    patch :update, params: { id: Grocery.last.id, grocery: { name: @name } }
    # assert_equal @name, Grocery.last.name
    assert_response :redirect
  end

  test 'should destroy grocery' do
    delete :destroy, params: { id: @grocery.id }
    assert_response :redirect # should be :success
  end

  test 'should get past' do
    get :past
    assert_response :success
  end
end
