require 'test_helper'

class RecipesHelperTest < ActionView::TestCase
  include TextHelper
  include RecipesHelper

  test 'sample recipe' do
    r = Recipe.create(title: 'Pancakes', user_id: 1)
    r.update_attribute(:shared_id, 'sample')
    assert_not_nil sample_recipe
  end

  test 'recipe embed' do
    assert_not_empty recipe_embed(recipes(:one))
  end

  test 'embed script' do
    assert_not_empty embed_script(recipes(:one))
  end

  test 'embed code' do
    assert_not_empty embed_code(recipes(:one))
  end

  test 'embed html' do
    assert_not_empty embed_html(recipes(:one))
  end

  test 'processed ingredient' do
    assert_match 'hello', ingredient_processed('hello')
  end

  test 'processed instructions' do
    assert_match 'hello', instructions_processed('hello')
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
