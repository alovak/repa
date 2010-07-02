require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
describe "/tickets/_ticket" do
  let(:ticket) { mock_model(Ticket, :null_object => true, :created_at => Time.now) }

  it "should have description" do
    ticket.stub(:description => 'Ticket description')

    render :locals => { :ticket => ticket }
    response.should have_tag('p', 'Ticket description')
  end

  it "should have title" do
    ticket.stub(:title => 'Ticket title')

    render :locals => { :ticket => ticket }
    response.should have_tag('h2', 'Ticket title')
  end

  it "should contain ticket state" do
    ticket.stub(:state => 'pending')

    render :locals => { :ticket => ticket }
    response.should have_tag('b.state', 'pending')
  end

  it "should contain assignee name" do
    ticket.stub!(:assignee => mock("Assignee", :name => "John"))

    render :locals => { :ticket => ticket }
    response.should have_tag('b', 'John')
  end

  it "should contains ticket owner name" do
    ticket.stub!(:owner => mock("Assignee", :name => "James"))

    render :locals => { :ticket => ticket }
    response.should have_tag("p.author", /James/)
  end
end
