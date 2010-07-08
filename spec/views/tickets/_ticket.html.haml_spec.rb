require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
describe "/tickets/_ticket" do
  let(:ticket) { mock_model(Ticket, :null_object => true, :created_at => Time.now) }

  it "should have description" do
    ticket.stub(:description => 'Ticket description')

    render :locals => { :ticket => ticket }
    response.should have_tag('.description', 'Ticket description')
  end

  it "should have title" do
    ticket.stub(:title => 'Ticket title')

    render :locals => { :ticket => ticket }
    response.should have_tag('.title', 'Ticket title')
  end

  it "should contain ticket state" do
    ticket.stub(:state => 'pending')

    render :locals => { :ticket => ticket }
    response.should have_tag('.state', 'pending')
  end

  it "should contain assignee name" do
    ticket.stub!(:assignee => mock("Assignee", :name => "John"))

    render :locals => { :ticket => ticket }
    response.should have_tag('.assignee', 'John')
  end

  it "should contain ticket owner name" do
    ticket.stub!(:owner => mock("Owner", :name => "James"))

    render :locals => { :ticket => ticket }
    response.should have_tag(".owner", /James/)
  end

  it "should contain ticket impact description" do
    ticket.stub!(:impact => 'Impact description')

    render :locals => { :ticket => ticket }
    response.should have_tag(".impact", "Impact description")
  end

  it "should contain ticket rollback process" do
    ticket.stub!(:rollback_process => 'Roll back process description')

    render :locals => { :ticket => ticket }
    response.should have_tag(".rollback_process", "Roll back process description")
  end
end
