require 'test_helper'

class NavHelperTest < ActionView::TestCase
  include NavHelper

  test 'should activate nav' do
    activate_nav!(:hello)
    nav_active?(:hello)
    assert true
  end

  test 'should return active class' do
    activate_nav!(:hello)
    assert_match(/bold/, nav_active_class(:hello))
  end
end
