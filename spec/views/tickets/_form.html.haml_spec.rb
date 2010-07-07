require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tickets/_form.html.erb" do
  let(:ticket) { stub_model(Ticket) }

  before(:each) do
    assigns[:ticket] = ticket
  end

  context "when new ticket" do
    before { ticket.stub(:new_record? => true) }

    it "should have form with post method" do
      render :partial => 'tickets/form', :locals => {:ticket => ticket, :submit_partial => '/common/create_or_cancel'}
      response.should have_tag("form[action=#{tickets_path}][method=post]")
    end

    it "should contain title, description, comment" do
      render :partial => 'tickets/form', :locals => {:ticket => ticket, :submit_partial => '/common/create_or_cancel'}

      response.should have_tag("form") do
        with_tag("input[name=?]", 'ticket[title]')
        with_tag("textarea[name=?]", 'ticket[description]')
        with_tag("textarea[name=?]", 'ticket[comment]')
      end
    end
 end



  context "when ticket is existed record" do
    before { ticket.stub(:new_record? => false, :owner => mock(:name => 'John'), :assignee => mock(:name => 'Bill')) }

    context "when current_user can't chnage ticket" do
      before do
        template.stub(:current_user => mock())
        ticket.stub(:changeable_by? => false)
      end

      it "should not have ticket events" do
        render :partial => 'tickets/form', :locals => {:ticket => ticket, :submit_partial => '/common/create_or_cancel'}

        response.should_not have_tag("select[name=?]", 'ticket[event]')
      end

      it "should not have users to assign" do
        render :partial => 'tickets/form', :locals => {:ticket => ticket, :submit_partial => '/common/create_or_cancel'}

        response.should_not have_tag("select[name=?]", 'ticket[assignee_id]')
      end
    end

    context "when current user can chnage ticket" do
      before do
        template.stub(:current_user => mock())
        ticket.stub(:changeable_by? => true)
      end

      it "should have ticket events" do
        ticket.stub(:aasm_events_for_current_state => %w(one two))
        render :partial => 'tickets/form', :locals => {:ticket => ticket, :submit_partial => '/common/create_or_cancel'}

        response.should have_tag("select[name=?]", 'ticket[event]') do
          with_tag("option", "one")
          with_tag("option", "two")
        end
      end

      it "should have users to assign" do
        User.stub(:all => [ mock(:name => 'John',  :id => '1'),
                            mock(:name => 'Steve', :id => '2') ] )

        render :partial => 'tickets/form', :locals => {:ticket => ticket, :submit_partial => '/common/create_or_cancel'}

        response.should have_tag("select[name=?]", 'ticket[assignee_id]') do
          with_tag("option[value=1]", "John")
          with_tag("option[value=2]", "Steve")
        end
      end
    end


    context "when ticket state is assigned" do
      before { ticket.stub(:state => 'assigned') }
      it "should contain impact, rollback_process fileds" do
        render :partial => 'tickets/form', :locals => {:ticket => ticket, :submit_partial => '/common/create_or_cancel'}

        response.should have_tag(".ticket") do
          without_tag("dd.impact")
          without_tag("dd.rollback_process")
        end
      end
    end

    context "when impact and rollback_process are blank" do
      before { ticket.stub(:impact => '', :rollback_process => '') }

      it "should not contain impact and rollback lables" do
        render :partial => 'tickets/form', :locals => {:ticket => ticket, :submit_partial => '/common/create_or_cancel'}
      end
    end

    it "should contain ticket attributes" do
      ticket.stub(:title => 'title',
                  :description => 'description',
                  :state => 'new',
                  :assignee => mock(:name => 'John'),
                  :owner => mock(:name => 'Bill'))

      render :partial => 'tickets/form', :locals => {:ticket => ticket, :submit_partial => '/common/create_or_cancel'}

      response.should have_tag(".ticket") do
        with_tag(".title", 'title')
        with_tag(".description", 'description')
        with_tag(".state", 'new')
        with_tag(".assignee", 'John')
        with_tag(".owner", 'Bill')
      end

    end
  end
end
