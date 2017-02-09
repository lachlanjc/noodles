require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper
  include SvgHelper

  test 'modal close' do
    assert_not_nil modal_close
  end

  test 'modal header' do
    assert_not_nil modal_header('hello')
  end
end
