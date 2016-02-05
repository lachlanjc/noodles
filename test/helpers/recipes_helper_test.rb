require 'test_helper'

class RecipesHelperTest < ActionView::TestCase
  include TextHelper
  include RecipesHelper

  test 'should generate recipe share path' do
    assert_equal '/s/goodcheese', shared_path(recipes(:one))
  end

  test 'should generate recipe share link' do
    assert_equal 'https://getnoodl.es/s/goodcheese', shared_url(recipes(:one))
  end

  test 'sample recipe' do
    r = Recipe.create(title: 'Pancakes', user_id: 1)
    r.shared_id = 'sample'
    r.save
    assert_not_nil sample_recipe
  end

  test 'should test recipe is from web' do
    assert from_web?('https://getnoodl.es/s/6ww5W0L')
  end

  test 'processed ingredient' do
    assert_not_empty ingredient_processed('hello')
  end

  test 'processed instructions' do
    assert_not_empty instructions_processed('hello')
  end

  test 'no details on recipe' do
    assert no_details?(recipes(:no_details))
  end

  test 'recipe has details' do
    assert_not no_details?(recipes(:one))
  end

  test 'notes blankslate' do
    assert_match 'No notes', notes_blankslate
  end

  test 'empty rendered notes' do
    assert_match 'No notes', notes_rendered(recipes(:no_details))
  end

  test 'rendered notes' do
    assert_match 'cheese', notes_rendered(recipes(:one))
  end
end
