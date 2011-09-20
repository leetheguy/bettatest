require 'spec_helper'

describe BetaTestsController do
  def mock_beta_test(stubs={})
    @mock_beta_test ||= mock_model(BetaTest, stubs).as_null_object
  end

  describe "GET index" do
    describe "allows everyone to view a list of all beta tests" do
      specify { can_has_access?(           ) { get :index } }
      specify { can_has_access?(unconfirmed) { get :index } }
      specify { can_has_access?(naughty    ) { get :index } }
      specify { can_has_access?(user       ) { get :index } }
      specify { can_has_access?(tester     ) { get :index } }
      specify { can_has_access?(developer  ) { get :index } }
      specify { can_has_access?(subscriber ) { get :index } }
    end

    it "assigns a paginated list of beta tests as @beta_tests" do
      beta_tests = []
      21.times{ beta_tests << Factory.create(:beta_test) }
      get :index, :page => "1"
      assigns(:beta_tests).count.should == 20
    end
  end

  describe "GET show" do
    describe "allows everyone to view beta tests" do
      specify { can_has_access?(           ) { get :show, :id => "42" } }
      specify { can_has_access?(unconfirmed) { get :show, :id => "42" } }
      specify { can_has_access?(naughty    ) { get :show, :id => "42" } }
      specify { can_has_access?(user       ) { get :show, :id => "42" } }
      specify { can_has_access?(tester     ) { get :show, :id => "42" } }
      specify { can_has_access?(developer  ) { get :show, :id => "42" } }
      specify { can_has_access?(subscriber ) { get :show, :id => "42" } }
    end

    it "assigns the requested beta_test as @beta_test" do
      #BetaTest.stub(:find).with("37") { mock_beta_test }
      navigate current_beta_test
      get :show, :id => current_beta_test.id
      assigns(:beta_test).should == current_beta_test
    end
  end

  describe "GET new" do
    describe "allows all confirmed users except developers to create a new beta test" do
      specify { can_has_access?   (user      ) { get :new } }
      specify { can_has_access?   (tester    ) { get :new } }
      specify { can_has_access?   (subscriber) { get :new } }
      specify { cannot_has_access?(developer ) { get :new } }
    end

    it "assigns a new beta_test as @beta_test" do
      BetaTest.stub(:new) { mock_beta_test }
      login user
      get :new
      assigns(:beta_test).should be(mock_beta_test)
    end

    it "assigns current_user to beta_test"
#      BetaTest.stub(:new) { mock_beta_test }
#      login user
#      get :new
#      assigns(:beta_test).user.id.should be(user.id)
#    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created beta_test as @beta_test" do
        login user
        BetaTest.stub(:new).with({'these' => 'params'}) { mock_beta_test(:save => true) }
        post :create, :beta_test => {'these' => 'params'}
        assigns(:beta_test).should be(mock_beta_test)
      end

      it "redirects to the created beta_test" do
        login user
        BetaTest.stub(:new) { mock_beta_test(:save => true) }
        post :create, :beta_test => {}
        response.should redirect_to(beta_test_url(mock_beta_test))
      end

      it "redirects to show page if cancel button clicked"
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved beta_test as @beta_test" do
        login user
        BetaTest.stub(:new).with({'these' => 'params'}) { mock_beta_test(:save => false) }
        post :create, :beta_test => {'these' => 'params'}
        assigns(:beta_test).should be(mock_beta_test)
      end

      it "re-renders the 'new' template" do
        login user
        BetaTest.stub(:new) { mock_beta_test(:save => false) }
        post :create, :beta_test => {}
        response.should render_template("new")
      end
    end
  end

  describe "GET edit" do
    let!(:btd) { Factory.create :beta_test }
    let!(:bts) { Factory.create :beta_test }

    before do
      developer.has_role! :developer, btd
      subscriber.has_role! :developer, bts
    end

    describe "allows developers access only to their own tests and admins complete access" do
      specify { can_has_access?   (developer ) { get :edit, :id => btd.id } }
      specify { cannot_has_access?(developer ) { get :edit, :id => bts.id } }
      specify { can_has_access?   (subscriber) { get :edit, :id => bts.id } }
      specify { cannot_has_access?(subscriber) { get :edit, :id => btd.id } }
    end

    it "assigns the requested beta_test as @beta_test" do
      login developer
      developer.has_role! :developer, btd
      get :edit, :id => btd.id
      assigns(:beta_test).id.should be(btd.id)
    end
  end

  describe "PUT update" do
    before do
      login admin
    end

    describe "with valid params" do
      it "updates the requested beta_test" do
        BetaTest.stub(:find).with("42") { mock_beta_test }
        mock_beta_test.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "42", :beta_test => {'these' => 'params'}
      end

      it "assigns the requested beta_test as @beta_test" do
        BetaTest.stub(:find) { mock_beta_test(:update_attributes => true) }
        put :update, :id => "42"
        assigns(:beta_test).should be(mock_beta_test)
      end

      it "toggles open state if it recieves the open param" do
        bt = Factory.create :beta_test, :open => false
        put :update, :id => bt.id, :beta_test => bt.id, :commit => 'make public'
        bt = BetaTest.find bt.id
        bt.open.should be_true
        put :update, :id => bt.id, :beta_test => bt.id, :commit => 'make private'
        bt = BetaTest.find bt.id
        bt.open.should be_false
        response.should render_template('edit')
      end

      it "toggles active state if it recieves the active param" do
        bt = Factory.create :beta_test, :active => false
        put :update, :id => bt.id, :beta_test => bt.id, :commit => 'activate'
        bt = BetaTest.find bt.id
        bt.active.should be_true
        put :update, :id => bt.id, :beta_test => bt.id, :commit => 'deactivate'
        bt = BetaTest.find bt.id
        bt.active.should be_false
        response.should render_template('edit')
      end
    end

    describe "with invalid params" do
      it "assigns the beta_test as @beta_test" do
        BetaTest.stub(:find) { mock_beta_test(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:beta_test).should be(mock_beta_test)
      end

      it "re-renders the 'edit' template" do
        BetaTest.stub(:find) { mock_beta_test(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      login admin
    end

    it "destroys the requested beta_test" do
      #BetaTest.stub(:find).with("37") { mock_beta_test }
      navigate current_beta_test
      delete :destroy, :id => current_beta_test.id
      lambda{ BetaTest.find(current_beta_test.id) }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
