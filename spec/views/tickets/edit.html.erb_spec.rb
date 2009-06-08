require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tickets/edit.html.erb" do
  include TicketsHelper
  
  before(:each) do
    assigns[:ticket] = @ticket = stub_model(Ticket,
      :new_record? => false
    )
  end

  it "should include form partial" do
    template.should_receive(:render).with(hash_including(:partial => 'form'))
    render
  end

  it "should contains 'Update' button" do
    render
    response.should have_tag("form[action=?][method=post]", ticket_path(@ticket)) do
      with_tag("input[type=submit][value='Обновить']")
    end
  end
end
