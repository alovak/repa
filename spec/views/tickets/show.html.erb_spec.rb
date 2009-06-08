require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tickets/show.html.erb" do
  include TicketsHelper
  before(:each) do
    assigns[:ticket] = @ticket = stub_model(Ticket)
  end

  it "should render _ticket partial" do
    template.should_receive(:render).with(hash_including(:partial => @ticket))
    render
  end

  it "should render _action partial" do
    template.should_receive(:render).with(hash_including(:partial => 'action'))
    render
  end

  it "should display form for change action and 'Update' button" do
    render
    response.should have_tag("form[action=?][method=post]", ticket_change_path(@ticket)) do
      with_tag("input[type=submit][value=Изменить]")
    end
  end
end

