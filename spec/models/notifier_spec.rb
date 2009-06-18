require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Notifier do
  before(:each) do
    @ticket = mock_model(Ticket, :null_object => true, :created_at => Time.now)
    @change = mock_model(Change, :null_object => true, :ticket => @ticket, :created_at => Time.now)
  end

  describe "email" do
    it "should contains subject" do
      @ticket.stub!(:id).and_return 7

      email = Notifier.create_ticket_change(@change)
      email.subject.should == "Ticket #7 was changed"
    end

    it "should contains ticket owner and ticket assignee in receivers" do
      @ticket.stub!(:owner).and_return mock("Owner", :name => "John Doe", :email => "john@example.com")
      @ticket.stub!(:assignee).and_return mock("Owner", :name => "Joe Black", :email => "joe@example.com")

      email = Notifier.create_ticket_change(@change)
      email['to'].to_s.should include("John Doe <john@example.com>")
      email['to'].to_s.should include("Joe Black <joe@example.com>")
    end
  end

  it "should send email" do
    ActionMailer::Base.deliveries = []
    lambda { 
      Notifier.deliver_ticket_change(@change) 
    }.should change(ActionMailer::Base.deliveries, :count).by(1)
  end
end
