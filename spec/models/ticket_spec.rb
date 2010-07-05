require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ticket do
  let(:ticket) { stub_model(Ticket) }
  let(:current_user) { mock() }

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:title) }

  context "when state is assigned" do
    before { subject.stub(:state => 'implementing') }

    it { should validate_presence_of(:impact) }
    it { should validate_presence_of(:rollback_process) }
  end

  context "when state is not assigned" do
    before { subject.stub(:state => 'pending') }

    it { should_not validate_presence_of(:impact) }
    it { should_not validate_presence_of(:rollback_process) }
  end


  context "when assignee is a current_user" do
    before do
      ticket.stub(:assignee => current_user)
    end

    it "should ba changeable by current_user" do
      ticket.should be_changeable_by(current_user)
    end
  end

  context "when assignee is not set and current_user is the owner" do
    before do
      ticket.stub(:assignee => nil, :owner => current_user)
    end

    it "should ba changeable by current_user" do
      ticket.should be_changeable_by(current_user)
    end
  end

  context "when assignee is not set" do
    before do
      ticket.stub(:assignee => nil)
    end

    it "should ba changeable by current_user" do
      ticket.should_not be_changeable_by(current_user)
    end
  end

  context "when assignee is set but it's not current_user" do
    before do
      ticket.stub(:assignee => mock('new user'))
    end

    it "should ba changeable by current_user" do
      ticket.should_not be_changeable_by(current_user)
    end
  end
end
