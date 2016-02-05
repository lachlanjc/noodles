require 'test_helper'

class NavHelperTest < ActionView::TestCase
  include NavHelper

  test 'should activate nav' do
    activate_nav!(:hello)
    assert nav_active?(:hello)
  end

  test 'should return active class' do
    activate_nav!(:hello)
    assert_match(/b/, nav_active_class(:hello))
  end
end
