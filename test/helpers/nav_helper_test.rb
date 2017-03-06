require 'test_helper'

class NavHelperTest < ActionView::TestCase
  include NavHelper

  test 'should activate nav' do
    activate_nav!(:hello)
    assert nav_active?(:hello)
  end

  test 'should return active class' do
    activate_nav! :hello
    assert_match /b/, nav_active_class(:hello)
  end

  test 'flash json' do
    flash[:success] = 'Hello'
    assert_not_nil flash_json
    assert flash_json.is_a? Array
    assert_match /Hello/, flash_json.to_s
  end

  test 'flash type' do
    assert_equal 'success', flash_type(:success)
    assert_equal 'danger', flash_type(:alert)
    assert_equal 'notice', flash_type(:info)
  end
end
