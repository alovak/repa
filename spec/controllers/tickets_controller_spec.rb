require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TicketsController do
  def mock_ticket(stubs={})
    @mock_ticket ||= mock_model(Ticket, stubs.update(:owner= => true))
  end


  describe "GET index" do
    it "assigns all tickets as @tickets" do
      Ticket.should_receive(:paginate).and_return([mock_ticket])
      get :index
      assigns[:tickets].should == [mock_ticket]
    end
  end

  describe "GET new" do
    it "assigns a new ticket as @ticket" do
      Ticket.stub!(:new).and_return(mock_ticket)
      get :new
      assigns[:ticket].should equal(mock_ticket)
    end
  end

  describe "GET edit" do
    it "assigns the requested ticket as @ticket" do
      Ticket.stub!(:find).with("37").and_return(mock_ticket)
      get :edit, :id => "37"
      assigns[:ticket].should equal(mock_ticket)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created ticket as @ticket" do
        Ticket.should_receive(:new).with({'these' => 'params'}).and_return(mock_ticket(:save => true))
        post :create, :ticket => {:these => 'params'}
        assigns[:ticket].should equal(mock_ticket)
      end

      it "set owner as current_user" do
        Ticket.stub!(:new).and_return(mock_ticket(:save => true))
        mock_ticket.should_receive(:owner=)
        post :create, :ticket => {}
      end

      it "redirects to the created ticket" do
        Ticket.stub!(:new).and_return(mock_ticket(:save => true))
        post :create, :ticket => {}
        response.should redirect_to(edit_ticket_url(mock_ticket))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ticket as @ticket" do
        Ticket.stub!(:new).with({'these' => 'params'}).and_return(mock_ticket(:save => false))
        post :create, :ticket => {:these => 'params'}
        assigns[:ticket].should equal(mock_ticket)
      end

      it "re-renders the 'new' template" do
        Ticket.stub!(:new).and_return(mock_ticket(:save => false))
        post :create, :ticket => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested ticket" do
        Ticket.should_receive(:find).with("37").and_return(mock_ticket)
        mock_ticket.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ticket => {:these => 'params'}
      end

      it "assigns the requested ticket as @ticket" do
        Ticket.stub!(:find).and_return(mock_ticket(:update_attributes => true))
        put :update, :id => "1"
        assigns[:ticket].should equal(mock_ticket)
      end

      it "redirects to the edit ticket" do
        Ticket.stub!(:find).and_return(mock_ticket(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(edit_ticket_url(mock_ticket))
      end
    end

    describe "with invalid params" do
      it "updates the requested ticket" do
        Ticket.should_receive(:find).with("37").and_return(mock_ticket)
        mock_ticket.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ticket => {:these => 'params'}
      end

      it "assigns the ticket as @ticket" do
        Ticket.stub!(:find).and_return(mock_ticket(:update_attributes => false))
        put :update, :id => "1"
        assigns[:ticket].should equal(mock_ticket)
      end

      it "re-renders the 'edit' template" do
        Ticket.stub!(:find).and_return(mock_ticket(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end
end
