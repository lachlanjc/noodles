require 'test_helper'

class ScrapingHelperTest < ActionView::TestCase
  include ScrapingHelper

  test 'nyt cooking scraper' do
    assert_equal 'Bacon, Lettuce and Plum Sandwiches', master_scrape('http://cooking.nytimes.com/recipes/1012732-bacon-lettuce-and-plum-sandwiches')['title']
  end

  test 'epicurious scraper' do
    assert_equal 'Sheet-Pan Grilled Cheese', master_scrape('http://www.epicurious.com/recipes/food/views/sheet-pan-grilled-cheese-56390006')['title']
  end

  test 'food and wine scraper' do
    assert_equal 'Chocolate Chip Cookie Ice Cream Bars', master_scrape('http://www.foodandwine.com/recipes/chocolate-chip-cookie-ice-cream-bars')['title']
  end

  test 'allrecipes scraper' do
    assert_equal 'Peppered Shrimp Alfredo', master_scrape('http://allrecipes.com/recipe/133128/peppered-shrimp-alfredo/')['title']
  end

  test 'martha stewart scraper' do
    assert_equal 'Blackberry-Raspberry Hand Pies', master_scrape('http://www.marthastewart.com/1004188/blackberry-raspberry-hand-pies')['title']
  end

  test 'food52 scraper' do
    assert_equal 'Carrot-Pineapple Cake with Cream Cheese Frosting', master_scrape('http://food52.com/recipes/38008-carrot-pineapple-cake-with-cream-cheese-frosting')['title']
  end

  test 'bon appetit scraper' do
    assert_equal 'Chocolate Chunk–Pumpkin Seed Cookies', master_scrape('http://www.bonappetit.com/recipe/chocolate-chunk-pumpkin-seed-cookies')['title']
  end

end
