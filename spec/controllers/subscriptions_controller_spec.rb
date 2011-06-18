require 'spec_helper'

describe SubscriptionsController do

  def mock_subscription(stubs={})
    @mock_subscription ||= mock_model(Subscription, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all subscriptions as @subscriptions" do
      login admin
      Subscription.stub(:all) { [mock_subscription] }
      get :index
      assigns(:subscriptions).should eq([mock_subscription])
    end
  end

  describe "GET show" do
    it "assigns the requested subscription as @subscription" do
      login admin
      Subscription.stub(:find).with("37") { mock_subscription }
      get :show, :id => "37"
      assigns(:subscription).should be(mock_subscription)
    end
  end

  describe "GET new" do
    specify { can_has_access?(user) { get :new } }
    specify { can_has_access?(tester) { get :new } }
    specify { can_has_access?(developer) { get :new } }
    specify { cannot_has_access?(subscriber) { get :new } }
    it "assigns a new subscription as @subscription" do
      login admin
      Subscription.stub(:new) { mock_subscription }
      get :new
      assigns(:subscription).should be(mock_subscription)
    end
  end

  describe "GET edit" do
    specify { can_has_access?(subscriber) { get :edit, :id => "42" } }
    it "assigns the requested subscription as @subscription" do
      login admin
      Subscription.stub(:find).with("37") { mock_subscription }
      get :edit, :id => "37"
      assigns(:subscription).should be(mock_subscription)
    end
  end

  describe "POST create" do
    before do
      login admin
    end

    describe "with valid params" do
      it "assigns a newly created subscription as @subscription" do
        Subscription.stub(:new).with({'these' => 'params'}) { mock_subscription(:save => true) }
        post :create, :subscription => {'these' => 'params'}
        assigns(:subscription).should be(mock_subscription)
      end

      it "redirects to the created subscription" do
        Subscription.stub(:new) { mock_subscription(:save => true) }
        post :create, :subscription => {}
        response.should redirect_to(subscription_url(mock_subscription))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved subscription as @subscription" do
        Subscription.stub(:new).with({'these' => 'params'}) { mock_subscription(:save => false) }
        post :create, :subscription => {'these' => 'params'}
        assigns(:subscription).should be(mock_subscription)
      end

      it "re-renders the 'new' template" do
        Subscription.stub(:new) { mock_subscription(:save => false) }
        post :create, :subscription => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before do
      login admin
    end

    describe "with valid params" do
      it "updates the requested subscription" do
        Subscription.stub(:find).with("37") { mock_subscription }
        mock_subscription.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :subscription => {'these' => 'params'}
      end

      it "assigns the requested subscription as @subscription" do
        Subscription.stub(:find) { mock_subscription(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:subscription).should be(mock_subscription)
      end

      it "redirects to the subscription" do
        Subscription.stub(:find) { mock_subscription(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(subscription_url(mock_subscription))
      end
    end

    describe "with invalid params" do
      it "assigns the subscription as @subscription" do
        Subscription.stub(:find) { mock_subscription(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:subscription).should be(mock_subscription)
      end

      it "re-renders the 'edit' template" do
        Subscription.stub(:find) { mock_subscription(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      login admin
    end

    it "destroys the requested subscription" do
      Subscription.stub(:find).with("37") { mock_subscription }
      mock_subscription.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the subscriptions list" do
      Subscription.stub(:find) { mock_subscription }
      delete :destroy, :id => "1"
      response.should redirect_to(subscriptions_url)
    end
  end

end
