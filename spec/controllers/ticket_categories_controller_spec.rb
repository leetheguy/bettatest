require 'spec_helper'

describe TicketCategoriesController do

  def mock_ticket_category(stubs={})
    @mock_ticket_category ||= mock_model(TicketCategory, stubs).as_null_object
  end

  before do
    navigate :beta_test => current_beta_test
  end

  specify { can_has_access?(same_developer) { get :index } }
  specify { cannot_has_access?(other_developer) { get :index } }

  describe "GET index" do
    it "assigns all ticket_categories in current beta_test as @ticket_categories" do
      login admin
      TicketCategory.stub(:where) { [mock_ticket_category(:beta_test => current_beta_test)] }
      get :index, :beta_test => current_beta_test.id
      assigns(:ticket_categories).should eq([mock_ticket_category])
    end
  end

  describe "GET show" do
    it "assigns the requested ticket_category as @ticket_category" do
      login admin
      TicketCategory.stub(:find).with("37") { mock_ticket_category }
      get :show, :id => "37"
      assigns(:ticket_category).should be(mock_ticket_category)
    end
  end

  describe "GET new" do
    it "assigns a new ticket_category as @ticket_category" do
      login admin
      TicketCategory.stub(:new) { mock_ticket_category }
      get :new
      assigns(:ticket_category).should be(mock_ticket_category)
    end
  end

  describe "GET edit" do
    it "assigns the requested ticket_category as @ticket_category" do
      login admin
      TicketCategory.stub(:find).with("37") { mock_ticket_category }
      get :edit, :id => "37"
      assigns(:ticket_category).should be(mock_ticket_category)
    end
  end

  describe "POST create" do
    before do
      login admin
    end

    describe "with valid params" do
      it "assigns a newly created ticket_category as @ticket_category" do
        TicketCategory.stub(:new).with({'these' => 'params'}) { mock_ticket_category(:save => true) }
        post :create, :ticket_category => {'these' => 'params'}
        assigns(:ticket_category).should be(mock_ticket_category)
      end

      it "redirects to the created ticket_category" do
        TicketCategory.stub(:new) { mock_ticket_category(:save => true) }
        post :create, :ticket_category => {}
        response.should redirect_to(ticket_category_url(mock_ticket_category))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ticket_category as @ticket_category" do
        TicketCategory.stub(:new).with({'these' => 'params'}) { mock_ticket_category(:save => false) }
        post :create, :ticket_category => {'these' => 'params'}
        assigns(:ticket_category).should be(mock_ticket_category)
      end

      it "re-renders the 'new' template" do
        TicketCategory.stub(:new) { mock_ticket_category(:save => false) }
        post :create, :ticket_category => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before do
      login admin
    end

    describe "with valid params" do
      it "updates the requested ticket_category" do
        TicketCategory.stub(:find).with("37") { mock_ticket_category }
        mock_ticket_category.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ticket_category => {'these' => 'params'}
      end

      it "assigns the requested ticket_category as @ticket_category" do
        TicketCategory.stub(:find) { mock_ticket_category(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:ticket_category).should be(mock_ticket_category)
      end

      it "redirects to the ticket_category" do
        TicketCategory.stub(:find) { mock_ticket_category(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(ticket_category_url(mock_ticket_category))
      end
    end

    describe "with invalid params" do
      it "assigns the ticket_category as @ticket_category" do
        TicketCategory.stub(:find) { mock_ticket_category(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:ticket_category).should be(mock_ticket_category)
      end

      it "re-renders the 'edit' template" do
        TicketCategory.stub(:find) { mock_ticket_category(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      login admin
    end

    it "destroys the requested ticket_category" do
      TicketCategory.stub(:find).with("37") { mock_ticket_category }
      mock_ticket_category.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the ticket_categories list" do
      TicketCategory.stub(:find) { mock_ticket_category }
      delete :destroy, :id => "1"
      response.should redirect_to(ticket_categories_url)
    end
  end

end
