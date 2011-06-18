require 'spec_helper'

describe TicketsController do

  def mock_ticket(stubs={})
    @mock_ticket ||= mock_model(Ticket, stubs).as_null_object
  end

  before do
    navigate :beta_test => current_beta_test
  end

  specify { can_has_access?(same_developer) { get :index } }
  specify { cannot_has_access?(other_developer) { get :index } }

  describe "GET index" do
    it "assigns all tickets as @tickets" do
      login admin
      Ticket.stub(:where) { [mock_ticket(:ticket_category => current_ticket_category)] }
      get :index, :ticket_category => current_ticket_category.id
      assigns(:tickets).should eq([mock_ticket])
    end
  end

  describe "GET show" do
    it "assigns the requested ticket as @ticket" do
      login admin
      Ticket.stub(:find).with("37") { mock_ticket }
      get :show, :id => "37"
      assigns(:ticket).should be(mock_ticket)
    end
  end

  describe "GET new" do
    it "assigns a new ticket as @ticket" do
      login admin
      Ticket.stub(:new) { mock_ticket }
      get :new
      assigns(:ticket).should be(mock_ticket)
    end
  end

  describe "GET edit" do
    it "assigns the requested ticket as @ticket" do
      login admin
      Ticket.stub(:find).with("37") { mock_ticket }
      get :edit, :id => "37"
      assigns(:ticket).should be(mock_ticket)
    end
  end

  describe "POST create" do
    before do
      login admin
    end

    describe "with valid params" do
      it "assigns a newly created ticket as @ticket" do
        Ticket.stub(:new).with({'these' => 'params'}) { mock_ticket(:save => true) }
        post :create, :ticket => {'these' => 'params'}
        assigns(:ticket).should be(mock_ticket)
      end

      it "redirects to the created ticket" do
        Ticket.stub(:new) { mock_ticket(:save => true) }
        post :create, :ticket => {}
        response.should redirect_to(ticket_url(mock_ticket))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ticket as @ticket" do
        Ticket.stub(:new).with({'these' => 'params'}) { mock_ticket(:save => false) }
        post :create, :ticket => {'these' => 'params'}
        assigns(:ticket).should be(mock_ticket)
      end

      it "re-renders the 'new' template" do
        Ticket.stub(:new) { mock_ticket(:save => false) }
        post :create, :ticket => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before do
      login admin
    end

    describe "with valid params" do
      it "updates the requested ticket" do
        Ticket.stub(:find).with("37") { mock_ticket }
        mock_ticket.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ticket => {'these' => 'params'}
      end

      it "assigns the requested ticket as @ticket" do
        Ticket.stub(:find) { mock_ticket(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:ticket).should be(mock_ticket)
      end

      it "redirects to the ticket" do
        Ticket.stub(:find) { mock_ticket(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(ticket_url(mock_ticket))
      end
    end

    describe "with invalid params" do
      it "assigns the ticket as @ticket" do
        Ticket.stub(:find) { mock_ticket(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:ticket).should be(mock_ticket)
      end

      it "re-renders the 'edit' template" do
        Ticket.stub(:find) { mock_ticket(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      login admin
    end

    it "destroys the requested ticket" do
      Ticket.stub(:find).with("37") { mock_ticket }
      mock_ticket.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the tickets list" do
      Ticket.stub(:find) { mock_ticket }
      delete :destroy, :id => "1"
      response.should redirect_to(tickets_url)
    end
  end

end
