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

  it "should allow event" do
    @ticket.state = :new
    @ticket.allow_event?(:approve).should be_true
  end

  it "should not allow event" do
    @ticket.state = :new
    @ticket.allow_event?(:test).should be_false
  end
end
