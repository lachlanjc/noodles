require 'test_helper'

class GroceriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::ControllerHelpers

  setup do
    sign_in users(:one)
    @grocery = groceries(:one)
  end

  test 'should get index' do
    get groceries_url
    assert_response :success
  end

  test 'should get new' do
    get new_grocery_url
    assert_response :success
  end

  test 'should create grocery' do
    assert_difference('Grocery.count') do
      post groceries_url, params: { grocery: { completed_at: @grocery.completed_at, name: @grocery.name, user_id: @grocery.user_id } }
    end

    assert_redirected_to grocery_url(Grocery.last)
  end

  test 'should update grocery' do
    patch grocery_url(@grocery), params: { grocery: { completed_at: @grocery.completed_at, name: @grocery.name, user_id: @grocery.user_id } }
    assert_redirected_to grocery_url(@grocery)
  end
end
