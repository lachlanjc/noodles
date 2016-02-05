require 'test_helper'

class SvgHelperTest < ActionView::TestCase
  include SvgHelper

  test 'inline svg' do
    assert_not_nil inline_svg('add.svg')
  end

  test 'social icon' do
    assert_not_nil social_icon('twitter')
  end
end
