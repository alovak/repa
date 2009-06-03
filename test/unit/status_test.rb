require 'test_helper'

class SatusTest < ActiveSupport::TestCase
  def test_status_name 
    status = Status.new(1)
    assert_equal 'new', status.name
  end
end

