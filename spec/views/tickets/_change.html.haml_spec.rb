require 'spec_helper'

describe "/tickets/_change.html.haml" do
  let(:change) {
    mock(:state_is  => 'new',
         :state_was => 'pending',
         :assignee_is => mock(:name => 'John'),
         :assignee_was => mock(:name => 'Bill'),
         :comment_is => 'comment')
  }

  it "should contain attributes" do
    render :partial => 'tickets/change', :locals => {:change => change}

    response.should have_tag(".change") do
      with_tag(".state_is", 'new')
      with_tag(".state_was", 'pending')
      with_tag(".assignee_was", 'Bill')
      with_tag(".assignee_is", 'John')
      with_tag(".comment", 'comment')
    end
  end

  it "should not contain assignees and comment when it is nil" do
    change.stub(:comment_is => nil, :assignee_is => nil, :assignee_was => nil)
    render :partial => 'tickets/change', :locals => {:change => change}
    response.should have_tag(".change") do
      without_tag(".assignee_was")
      without_tag(".assignee_is")
      without_tag(".comment_is")
    end
  end
end
