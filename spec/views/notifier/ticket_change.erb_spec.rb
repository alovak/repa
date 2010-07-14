require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/notifier/ticket_change" do
  let(:ticket) {
    stub_model( Ticket,
                { :title => 'Ticket title',
                  :description => 'Ticket description',
                  :owner => mock(:name => 'John Owner'),
                  :assignee => mock(:name => 'Bill Assignee'),
                  :created_at => Time.now })
  }

  let(:change) { stub_model(Change, :ticket => ticket) }

  before(:each) do
    assigns[:change] = change
    assigns[:ticket] = ticket
  end

  it "should contain ticket info" do
    render

    response.should have_text(/#{edit_ticket_url(change.ticket)}/)

    ['Ticket title', 'Ticket description', 'John Owner', 'Bill Assignee'].each do |word|
      response.should include_text(word)
    end
  end

  it "should contain change info" do
    change.stub({ :state_is => 'new',
                  :state_was => 'accepted',
                  :assignee_is => mock(:name => 'John'),
                  :assignee_was => mock(:name => 'Bill'),
                  :comment_is => 'comment' })

    render

    %w(new accepted John Bill comment).each do |word|
      response.should include_text(word)
    end
  end

  it "should not contain change attribute if it's not set" do
    render

    ['State is', 'State was', 'Assignee is', 'Assignee was', 'Comment'].each do |word|
      response.should_not include_text(word)
    end
  end

end
