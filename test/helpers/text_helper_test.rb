require 'test_helper'

class TextHelperTest < ActionView::TestCase
  include TextHelper

  test 'markdown' do
    assert_not_nil markdown('hello')
  end

  test 'plain text from markdown' do
    assert_not_nil plain_text_from_markdown('hello')
  end

  test 'whitened markdown' do
    assert_not_nil whitened_markdown('hello')
  end

  test 'remove url head' do
    assert_equal 'getnoodl.es', remove_url_head('https://getnoodl.es')
  end

  test 'strip whitespace' do
    assert_equal '', strip_whitespace("   \n")
  end

  test 'clean autolink' do
    assert_not_nil clean_autolink('https://getnoodl.es')
  end
end
