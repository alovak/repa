require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
describe "/tickets/_ticket" do
  before(:each) do
    @ticket = mock_model(Ticket, :null_object => true, :created_at => Time.now)
  end

  it "should contains title" do
    @ticket.stub!(:title).and_return "the title"
    render 'tickets/_ticket', :locals => { :ticket => @ticket }
    response.should have_tag('h2', :text => @ticket.title)
  end

  it "should contains current state" do
    @ticket.stub!(:state).and_return "pending"
    render 'tickets/_ticket', :locals => { :ticket => @ticket }
    response.should have_tag('b.state', :text => @ticket.state)
  end

  it "should contains assignee name" do
    @ticket.stub!(:assignee).and_return mock("Assignee", :name => "John")
    render 'tickets/_ticket', :locals => { :ticket => @ticket }
    response.should have_tag('b', :text => "John")
  end

  it "should contains ticket owner name" do
    @ticket.stub!(:owner).and_return mock("Assignee", :name => "John")
    render 'tickets/_ticket', :locals => { :ticket => @ticket }
    response.should have_tag("p.author", /John/)
  end
end
