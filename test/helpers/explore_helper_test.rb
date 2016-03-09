require 'test_helper'

class ExploreHelperTest < ActionView::TestCase
  include ExploreHelper

  test 'nyt explore results' do
    assert_not_nil find_explore_results('nyt', 'pancakes')
  end

  test 'epicurious explore results' do
    assert_not_nil find_explore_results('epicurious', 'pancakes')
  end

  test 'allrecipes explore results' do
    assert_not_nil find_explore_results('allrecipes', 'pancakes')
  end

  test 'explore preview' do
    data = {'title' => 'Pancakes', 'description' => '', 'ingredients' => ['2 cups flour', '2 eggs'], 'instructions' => ''}
    recipe = prepare_explore_preview(data)
    assert_not_nil recipe
    assert_equal recipe.title, 'Pancakes'
  end
end
