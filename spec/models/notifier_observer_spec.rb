require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NotifierObserver do
  before(:each) do
    @change = Change.new
  end

  it "should deliver notification after change was created" do
    Notifier.should_receive(:deliver_ticket_change).with(@change)
    @change.save!
  end
end
