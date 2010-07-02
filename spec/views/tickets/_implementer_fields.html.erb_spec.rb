require 'spec_helper'
describe "/tickets/_implementer_fields" do
  it "should have impact and rollback_process" do
    render
    response.should have_tag('textarea[name=?]', 'ticket[impact]')
    response.should have_tag('textarea[name=?]', 'ticket[rollback_process]')
  end
end
