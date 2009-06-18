require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/notifier/ticket_change" do
  before(:each) do
    assigns[:change] = @change = mock_model(Change, :null_object => true, :created_at => Time.now)
  end
  
  describe "ticket info" do
    it "should contains link" do
      render '/notifier/ticket_change.text.plain'
      response.should have_text(/#{ticket_url(@change.ticket)}/)
    end
  end
end
