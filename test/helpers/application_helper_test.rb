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

  test 'backlink' do
    assert_match 'running tests', backlink('running tests', root_url)
  end

  test 'making a schema' do
    assert_not_nil make_schema
  end

  test 'org schema' do
    assert_not_nil org_schema
  end
end
