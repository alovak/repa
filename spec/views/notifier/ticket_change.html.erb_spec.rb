require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/notifier/ticket_change" do
  before(:each) do
    assigns[:change] = @change = mock_model(Change, :null_object => true, :created_at => Time.now)
  end
  
  describe "ticket info" do
    it "should contains link" do
      render '/notifier/ticket_change'

      response.should have_tag('a[href=?]', ticket_url(@change.ticket))
    end


    it "should render tickets/_ticket partial" do
      message = "rendered form 'tickets/ticket' partial"
      template.should_receive(:render).with(
        :partial => "tickets/ticket", 
        :locals => { :ticket => @change.ticket } 
      ).and_return message

      render '/notifier/ticket_change'
      response.should have_text(/#{message}/)
    end

    it "should render tickets/_change partial" do
      message = "rendered form 'tickets/change' partial"
      template.should_receive(:render).with(
        :partial => "tickets/change", 
        :locals => { :change => @change } 
      ).and_return message

      render '/notifier/ticket_change'
      response.should have_text(/#{message}/)
    end
  end

end
