require 'test_helper'

class CollectionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    sign_in users(:one)
    @collection = collections(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:collections)
  end

  test 'should create collection' do
    assert_difference('Collection.count') do
      post :create, collection: { name: @collection.name, description: @collection.description }
    end

    assert_redirected_to collection_path(assigns(:collection))
  end

  test 'should show collection' do
    get :show, id: @collection.id
    assert_response :success
  end

  test 'should update collection' do
    patch :update, id: @collection, collection: { name: @collection.name, description: @collection.description }
    assert_redirected_to collection_path(assigns(:collection))
  end

  test 'should destroy collection' do
    assert_difference('Collection.count', -1) do
      delete :destroy, id: @collection.id
    end

    assert_redirected_to collections_path
  end
end
