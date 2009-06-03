require 'test_helper'

class RandTest < ActiveSupport::TestCase
  def test_generate_random_string
    assert_not_equal String.random_string(4), String.random_string(4)
    assert_equal String.random_string(8).size, 8
    assert_equal String.random_string(20).size, 20
  end
end
