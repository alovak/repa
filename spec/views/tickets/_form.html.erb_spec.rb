require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tickets/_form.html.erb" do
  include TicketsHelper
  before(:each) do
    assigns[:ticket] = @ticket = stub_model(Ticket)
  end

  it "should contains form fields" do
    render :partial => 'tickets/form', :locals => {:ticket => @ticket, :submit_partial => '/common/create_or_cancel'}

    response.should have_tag("form[action=#{ticket_path(@ticket)}][method=post]") do
      with_tag("input#ticket_title")
    end
  end
end

