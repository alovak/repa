require 'spec_helper'

describe TicketObserver do
  let(:observer) { TicketObserver.instance }

  describe "#before_save" do
    context "when ticket changed" do
      it "should create Change when ticket changed" do
        ticket = Factory.create(:ticket)

        state_was, ticket.state = ticket.state, 'new'
        assignee_was, ticket.assignee = ticket.assignee, Factory.create(:user)
        comment_was, ticket.comment = ticket.comment, 'new comment'

        Change.should_receive(:create).with(:state_was => state_was,
                                            :state_is => 'new',
                                            :assignee_id_was => assignee_was.id,
                                            :assignee_id_is => ticket.assignee.id,
                                            :comment_was => comment_was,
                                            :comment_is => 'new comment',
                                            :ticket_id => ticket.id)
        observer.before_save(ticket)
      end
    end
  end
end
