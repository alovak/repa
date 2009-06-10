require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Change do
  context "state and assignee were changed" do
    describe "state" do
      before(:each) do
        @ticket = mock_model(Ticket, {
          :state_changed? => true,
          :state_was      => :new,
          :state          => :open,
        })
      end

      it "should set state_changed to true" do
        change = Change.build(@ticket)
        change.state_changed?.should be_true
      end
    end
  end
  context "assignee was changed" do
    before(:each) do
      @ticket = mock_model(Ticket, {
        :assignee_id_changed? => true,
        :assignee_id_was      => 1,
        :assignee_id          => 2,
      })
    end

    it "should set assignee_changed to true" do
      change = Change.build(@ticket)
      change.assignee_changed?.should be_true
    end

    it "should set assignee_was to previous assignee_id" do
      @ticket.stub!(:assignee_id_was).and_return(9)

      change = Change.build(@ticket)
      change.assignee_was.should == 9
    end

    it "should set assignee_is to current assignee_id" do
      @ticket.stub!(:assignee_id).and_return(7)

      change = Change.build(@ticket)
      change.assignee_is.should == 7
    end
  end
end
