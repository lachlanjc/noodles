require 'test_helper'

class CookControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @recipe = recipes(:one)
  end

  teardown do
    Rails.cache.clear
  end

  test 'should get index' do
    sign_in users(:one)
    get :index, params: { id: @recipe.id }
    assert_response :success
  end

  test 'should record analytics' do
    sign_in users(:one)
    last = @recipe.last_cooked_at
    assert_difference '@recipe.cooks_count' do
      get :record_cook, params: { id: @recipe.id }
      assert_response :success
      @recipe.reload
    end
    assert_not_equal last, @recipe.last_cooked_at
  end

  test 'should not be locked out' do
    get :index, params: { shared_id: @recipe.shared_id }
    assert_response :success
  end
end
