require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
describe "action partial" do
  it "should contains allowed events for ticket" do
    @ticket.stub!(:aasm_events_for_current_state).and_return([:one, :two])

    render(:partial => 'tickets/action')
    assigns[:ticket].aasm_events_for_current_state.each do |event|
      response.should have_tag("select#ticket_action option[value=?]", event)
    end
  end
end
