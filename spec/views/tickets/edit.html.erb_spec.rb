# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tickets/edit.html.erb" do
  include TicketsHelper

  before(:each) do
    assigns[:ticket] = @ticket = mock_model(Ticket, :null_object => true)
  end

  it "should include partials" do
    template.should_receive(:render).with(hash_including(:partial => 'form'))
    template.should_receive(:render).with(hash_including(:partial => 'change'))
    render
  end
end
