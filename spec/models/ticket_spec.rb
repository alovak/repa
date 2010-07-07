require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ticket do
  let(:current_user) { mock() }

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:title) }

  describe "#original_assignee" do
    it "should be nil when new record" do
      subject.original_assignee.should be_nil
    end

    it "should be the same as assignee_was when assignee was changed" do
      assignee_was = mock()
      User.should_receive(:find_by_id).with(1).and_return(assignee_was)
      subject.stub(:assignee_id_changed? => true, :assignee_id_was => 1)

      subject.original_assignee.should == assignee_was
    end

    it "should be nil if there was no assignee before assignee was changed" do
      subject.stub(:assignee_id_changed? => true, :assignee_id_was => nil)

      subject.original_assignee.should == nil
    end

    it "should be the same as assignee when assignee was not changed" do
      assignee = mock()
      subject.stub(:assignee_id_changed? => false, :assignee => assignee)

      subject.original_assignee.should == assignee
    end

  end

  context "when valid" do
    before do
      subject.attributes = {:title => 'title', :description => 'description'}
    end

    it { should be_valid }

    it "should receive call_event before save" do
      subject.should_receive(:call_event)
      subject.save
    end
  end

  context "when event is assigned" do
    before { subject.stub(:event => 'accept') }

    it { should validate_presence_of(:impact) }
    it { should validate_presence_of(:rollback_process) }
  end

  context "when event is not accept" do
    before { subject.stub(:event => 'approve') }

    it { should_not validate_presence_of(:impact) }
    it { should_not validate_presence_of(:rollback_process) }
  end


  context "when assignee is a current_user" do
    before { subject.stub(:assignee => current_user) }

    it { should be_changeable_by(current_user) }
  end

  context "when assignee is not set" do
    before { subject.stub(:assignee => nil) }

    it { should be_changeable_by(current_user) }
  end

  context "when assignee is set but it's not current_user" do
    before { subject.stub(:assignee => mock('new user')) }

    it { should_not be_changeable_by(current_user) }
  end
end
