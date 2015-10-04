require 'test_helper'

class RecipesHelperTest < ActionView::TestCase
  include MarkdownHelper
  include RecipesHelper

  test 'should generate shared id' do
    assert_equal 'w0aLgD', generate_shared_id(1)
  end

  test 'should generate recipe share link' do
    assert_equal 'http://test.host/s/goodcheese', shared_url(recipes(:one))
  end

  test 'should test recipe is from web' do
    assert from_web?('http://www.getnoodl.es/s/6ww5W0L')
  end

  test 'processed ingredients should work' do
    assert_not_empty ingredient_processed('hello')
  end
end
