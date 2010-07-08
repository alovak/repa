# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tickets/edit.html.erb" do
  include TicketsHelper

  let(:ticket) { mock_model(Ticket, :null_object => true) }
  before(:each) do
    assigns[:ticket] = ticket
  end

  it "should include partials" do
    template.should_receive(:render).with(hash_including(:partial => 'form'))
    template.should_receive(:render).with(hash_including(:partial => 'ticket'))
    template.should_not_receive(:render).with(hash_including(:partial => 'change'))
    render
  end

  context "when ticket has changes" do
    before { ticket.stub(:changes => ['one', 'two']) }
    it "should render changes partial" do
      template.should_not_receive(:render).with(hash_including(:partial => 'change'))
    end
  end
end
