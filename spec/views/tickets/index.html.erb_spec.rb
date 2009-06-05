require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tickets/index.html.erb" do
  include TicketsHelper
  
  before(:each) do
    assigns[:tickets] = [
      stub_model(Ticket),
      stub_model(Ticket)
    ]
  end

  it "renders a list of tickets" do
    render
  end
end

