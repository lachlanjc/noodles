require 'test_helper'

class ScrapingHelperTest < ActionView::TestCase
  include ScrapingHelper

  def check_recipe(title, url)
    @recipe = master_scrape(url)
    assert_equal @recipe[:title], title
    assert_not_nil @recipe[:description]
    assert_not_nil @recipe[:ingredients]
    assert_not_nil @recipe[:instructions]
  end

  # test 'nyt cooking import' do
  #   check_recipe('Bacon, Lettuce and Plum Sandwiches', 'http://cooking.nytimes.com/recipes/1012732-bacon-lettuce-and-plum-sandwiches')
  # end

  test 'epicurious import' do
    check_recipe('Sheet-Pan Grilled Cheese', 'http://www.epicurious.com/recipes/food/views/sheet-pan-grilled-cheese-56390006')
  end

  test 'fw import' do
    check_recipe('Chocolate Chip Cookie Ice Cream Bars', 'https://www.foodandwine.com/recipes/chocolate-chip-cookie-ice-cream-bars')
  end

  # test 'allrecipes import' do
  #   check_recipe('Peppered Shrimp Alfredo', 'http://allrecipes.com/recipe/133128/peppered-shrimp-alfredo/')
  # end

  test 'food52 import' do
    check_recipe('Carrot-Pineapple Cake with Cream Cheese Frosting', 'https://food52.com/recipes/38008-carrot-pineapple-cake-with-cream-cheese-frosting')
  end

  # test 'bon appetit import' do
  #   check_recipe('Chocolate Chunk–Pumpkin Seed Cookies', 'https://www.bonappetit.com/recipe/chocolate-chunk-pumpkin-seed-cookies')
  # end
end
