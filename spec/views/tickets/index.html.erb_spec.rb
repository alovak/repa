# require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

# describe "/tickets/index.html.erb" do
#   include TicketsHelper

#   before(:each) do
#     template.stub(:will_paginate => true)

#     assigns[:tickets] = @tickets = [
#       stub_model(Ticket),
#       stub_model(Ticket)
#     ]
#   end

#   it "renders a list of tickets" do
#     render

#     @tickets.each do |ticket|
#       response.should have_tag("td", :text => ticket.created_at[:short])
#     end
#   end
# end
