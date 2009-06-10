require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TicketsController do
  fixtures :users, :tickets

  before do
    session[:user_id] = User.find(:first)
  end

  def mock_ticket(stubs={})
    @mock_ticket ||= mock_model(Ticket, stubs)
  end

  #def mock_user(stubs={})
    #@mock_user ||= mock_model(User, stubs)
  #end

  describe "GET index" do
    it "assigns all tickets as @tickets" do
      Ticket.stub!(:find).with(:all).and_return([mock_ticket])
      get :index
      assigns[:tickets].should == [mock_ticket]
    end
  end

  describe "GET show" do
    it "assigns the requested ticket as @ticket" do
      Ticket.stub!(:find).with("37").and_return(mock_ticket)
      get :show, :id => "37"
      assigns[:ticket].should equal(mock_ticket)
    end

    it "assigns all users as @user" do
      mock_user = User.find(:first)
      Ticket.stub!(:find).with("37").and_return(mock_ticket)
      User.should_receive(:find_by_id).and_return(mock_user)
      User.should_receive(:find).with(:all).and_return([mock_user])
      get :show, :id => "37"
      assigns[:users].should eql([mock_user])
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
        Ticket.stub!(:new).with({'these' => 'params'}).and_return(mock_ticket(:save => true))
        post :create, :ticket => {:these => 'params'}
        assigns[:ticket].should equal(mock_ticket)
      end

      it "redirects to the created ticket" do
        Ticket.stub!(:new).and_return(mock_ticket(:save => true))
        post :create, :ticket => {}
        response.should redirect_to(ticket_url(mock_ticket))
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

      it "redirects to the ticket" do
        Ticket.stub!(:find).and_return(mock_ticket(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(ticket_url(mock_ticket))
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

  describe "DELETE destroy" do
    it "destroys the requested ticket" do
      Ticket.should_receive(:find).with("37").and_return(mock_ticket)
      mock_ticket.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the tickets list" do
      Ticket.stub!(:find).and_return(mock_ticket(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(tickets_url)
    end
  end

  describe "PUT change" do
    it "should change the requested ticket and assign it to @ticket" do
      Ticket.should_receive(:find).with("1").and_return(mock_ticket)
      mock_ticket.stub!(:allow_event?)
      mock_ticket.stub!(:event!)
      put :change, :id => "1", :ticket => {:action => 'event'}
      assigns[:ticket].should equal(mock_ticket)
    end

    it "should redirect to the 'show' template" do
      Ticket.stub!(:find).and_return(mock_ticket)
      mock_ticket.stub!(:allow_event?)
      mock_ticket.stub!(:event!)
      put :change, :id => "1", :ticket => {:action => 'event'}
      response.should redirect_to(ticket_url(mock_ticket))
    end
    
    it "should invoke the 'event' action passed in params" do
      Ticket.stub!(:find).and_return(mock_ticket)
      mock_ticket.should_receive(:allow_event?).with('event').and_return(true)
      mock_ticket.should_receive(:event!)
      put :change, :id => "1", :ticket => {:action => 'event'}
      flash[:notice].should == 'Ticket was successfully updated'
    end

    it "should not invoke forbidden or unknow event for ticket" do
      Ticket.stub!(:find).and_return(mock_ticket)
      mock_ticket.should_receive(:allow_event?).with('unknown').and_return(false)
      mock_ticket.should_not_receive(:unknow!)
      put :change, :id => "1", :ticket => {:action => 'unknown'}
      flash[:error].should == 'Invalid ticket event'
    end

    it "should not invoke forbidden or unknow event for empty ticket params" do
      Ticket.stub!(:find).and_return(mock_ticket)
      mock_ticket.should_not_receive(:allow_event?)
      put :change, :id => "1"
      flash[:error].should == 'Invalid ticket event'
    end
  end
end
