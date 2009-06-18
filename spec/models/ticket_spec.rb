require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ticket do
  before(:each) do
    @valid_attributes = {
    }
    @ticket = Ticket.new
  end

  it "should create a new instance given valid attributes" do
    Ticket.create!(@valid_attributes)
  end
end
