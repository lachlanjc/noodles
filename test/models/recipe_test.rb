require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  test 'from web' do
    assert recipes(:two).from_web?
  end
end
