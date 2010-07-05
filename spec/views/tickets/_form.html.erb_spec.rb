require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tickets/_form.html.erb" do
  let(:ticket) { Ticket.new }

  before(:each) do
    assigns[:ticket] = ticket
  end

  it "should contain title, description, comment" do
    render :partial => 'tickets/form', :locals => {:ticket => ticket, :submit_partial => '/common/create_or_cancel'}

    response.should have_tag("form[action=#{tickets_path}][method=post]") do
      with_tag("input[name=?]", 'ticket[title]')
      with_tag("textarea[name=?]", 'ticket[description]')
      with_tag("textarea[name=?]", 'ticket[comment]')
    end
  end

  it "should have ticket events" do
    ticket.stub(:aasm_events_for_current_state => %w(one two))

    render :partial => 'tickets/form', :locals => {:ticket => ticket, :submit_partial => '/common/create_or_cancel'}

    response.should have_tag("select[name=?]", 'ticket[event]') do
      with_tag("option", "one")
      with_tag("option", "two")
    end
  end

  it "should have users" do
    User.stub(:all => [ mock(:name => 'John',  :id => '1'),
                        mock(:name => 'Steve', :id => '2') ] )

    render :partial => 'tickets/form', :locals => {:ticket => ticket, :submit_partial => '/common/create_or_cancel'}

    response.should have_tag("select[name=?]", 'ticket[assignee_id]') do
      with_tag("option[value=1]", "John")
      with_tag("option[value=2]", "Steve")
    end
  end
end
