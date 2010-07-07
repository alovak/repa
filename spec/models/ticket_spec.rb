require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ticket do
  let(:current_user) { mock() }

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:title) }

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

  context "when assignee is not set and current_user is the owner" do
    before { subject.stub(:assignee => nil, :owner => current_user) }

    it { should be_changeable_by(current_user) }
  end

  context "when assignee is not set" do
    before { subject.stub(:assignee => nil) }

    it { should_not be_changeable_by(current_user) }
  end

  context "when assignee is set but it's not current_user" do
    before { subject.stub(:assignee => mock('new user')) }

    it { should_not be_changeable_by(current_user) }
  end
end
