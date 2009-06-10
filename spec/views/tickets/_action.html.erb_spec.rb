require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
describe "action partial" do
  before(:each) do
    assigns[:ticket] = @ticket = stub_model(Ticket, {
      :aasm_events_for_current_state => [:one, :two]
    })
    assigns[:users] = [
      stub_model(User, :name => 'John'),
      stub_model(User, :name => 'Bill')
    ]
  end
  it "should contains allowed events for ticket" do

    render(:partial => 'tickets/action')
    assigns[:ticket].aasm_events_for_current_state.each do |event|
      response.should have_tag("select#ticket_action option[value=?]", event)
    end
  end

  it "should contains users to assign ticket" do

    render(:partial => 'tickets/action')
    assigns[:users].each do |user|
      response.should have_tag("select#ticket_assignee_id option[value=?]", user.id)
    end
  end
end
