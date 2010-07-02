require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
describe "/tickets/_action" do
  let(:ticket) { mock_model(Ticket, :null_object => true, :created_at => Time.now) }

  before do
    assigns[:ticket] = ticket
    comment = mock_model(Comment).as_new_record
    assigns[:change] = mock_model(Change, :comment => comment).as_new_record
    assigns[:comment] = comment
  end

  context "when ticket state is assigned" do
    before do
      ticket.stub(:state => 'assigned')
    end

    it "should render partial with additional params" do
      template.should_receive(:render).with(:partial => 'implementer_fields')
      render
    end
  end

  context "when ticket state is not assigned" do
    before do
      ticket.stub(:state => 'new')
    end

    it "should render partial with additional params" do
      template.should_not_receive(:render).with(:partial => 'implementer_fields')
      render
    end
  end
end
