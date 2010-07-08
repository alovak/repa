require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NotifierObserver do
  it "should deliver notification after change was created" do
    ticket = Factory(:ticket)
    Notifier.should_receive(:deliver_ticket_change).with(ticket)
    ticket.save!
  end
end
