require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tickets/new.html.erb" do
  include TicketsHelper
  
  before(:each) do
    assigns[:ticket] = stub_model(Ticket,
      :new_record? => true
    )
  end

  it "should include form partial" do
    template.should_receive(:render).with(hash_including(:partial => 'form'))
    render
  end

  it "should contains 'Create' button" do
    render
    response.should have_tag("form[action=?][method=post]", tickets_path) do
      with_tag("input[type=submit][value='Создать']")
    end
  end
end


