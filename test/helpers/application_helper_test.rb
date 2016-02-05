require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper
  include SvgHelper

  test 'flash color' do
    assert_equal 'red', flash_color_class(:red)
  end

  test 'app url' do
    assert_equal app_url, 'https://getnoodl.es'
  end

  test 'modal close' do
    assert_not_nil modal_close
  end

  test 'modal header' do
    assert_not_nil modal_header('hello')
  end
end
