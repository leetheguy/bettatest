require 'spec_helper'

describe TesterStatSheetsController do
  before do
    navigate :beta_test => current_beta_test
  end

  specify { can_has_access?(approved_activated_tester)      { get :index } }

  specify { can_has_access?(same_developer)                 { get :index } }

  specify { can_has_access?(user)                           { post :create } }

  specify { cannot_has_access?(same_developer)              { post :create } }

  specify { cannot_has_access?(approved_activated_tester)   { post :create } }

  describe "GET index" do
    it "assigns all tester_stat_sheets as @tester_stat_sheets"# do
#      login admin
#      get :index
#      assigns(:tester_stat_sheets).should be_a_kind_of(Array)
#    end
  end
#
#  describe "GET show" do
#    it "assigns the requested tester_stat_sheet as @tester_stat_sheet" do
#      TesterStatSheet.stub(:find).with("37") { mock_tester_stat_sheet }
#      get :show, :id => "37"
#      assigns(:tester_stat_sheet).should be(mock_tester_stat_sheet)
#    end
#  end
#
#  describe "GET new" do
#    it "assigns a new tester_stat_sheet as @tester_stat_sheet" do
#      TesterStatSheet.stub(:new) { mock_tester_stat_sheet }
#      get :new
#      assigns(:tester_stat_sheet).should be(mock_tester_stat_sheet)
#    end
#  end
#
#  describe "GET edit" do
#    it "assigns the requested tester_stat_sheet as @tester_stat_sheet" do
#      TesterStatSheet.stub(:find).with("37") { mock_tester_stat_sheet }
#      get :edit, :id => "37"
#      assigns(:tester_stat_sheet).should be(mock_tester_stat_sheet)
#    end
#  end
#
  describe "POST create" do
#      it "allows a valid user to join an active betta test" do
#        login user
#        post :create, :tester_stat_sheet => { :beta_test_id => current_beta_test.id }
#
#
#        
#      end

    it "won't let you join an open beta test" do
      login user
      current_beta_test
      current_beta_test.open = true
      current_beta_test.save
      post :create
      response.should be_redirect
    end

    it "won't let you join an inactive beta test" do
      login user
      current_beta_test
      current_beta_test.active = false
      current_beta_test.save
      post :create
      response.should be_redirect
    end

    it "assigns a newly created tester_stat_sheet as @tester_stat_sheet" do
      login user
      current_beta_test
      post :create
      assigns(:tester_stat_sheet).should be_an_instance_of(TesterStatSheet)
    end

    it "puts users on waiting list if test is full"
  end
#
#  describe "PUT update" do
#    describe "with valid params" do
#      it "updates the requested tester_stat_sheet" do
#        TesterStatSheet.stub(:find).with("37") { mock_tester_stat_sheet }
#        mock_tester_stat_sheet.should_receive(:update_attributes).with({'these' => 'params'})
#        put :update, :id => "37", :tester_stat_sheet => {'these' => 'params'}
#      end
#
#      it "assigns the requested tester_stat_sheet as @tester_stat_sheet" do
#        TesterStatSheet.stub(:find) { mock_tester_stat_sheet(:update_attributes => true) }
#        put :update, :id => "1"
#        assigns(:tester_stat_sheet).should be(mock_tester_stat_sheet)
#      end
#
#      it "redirects to the tester_stat_sheet" do
#        TesterStatSheet.stub(:find) { mock_tester_stat_sheet(:update_attributes => true) }
#        put :update, :id => "1"
#        response.should redirect_to(tester_stat_sheet_url(mock_tester_stat_sheet))
#      end
#    end
#
#    describe "with invalid params" do
#      it "assigns the tester_stat_sheet as @tester_stat_sheet" do
#        TesterStatSheet.stub(:find) { mock_tester_stat_sheet(:update_attributes => false) }
#        put :update, :id => "1"
#        assigns(:tester_stat_sheet).should be(mock_tester_stat_sheet)
#      end
#
#      it "re-renders the 'edit' template" do
#        TesterStatSheet.stub(:find) { mock_tester_stat_sheet(:update_attributes => false) }
#        put :update, :id => "1"
#        response.should render_template("edit")
#      end
#    end
#  end
#
#  describe "DELETE destroy" do
#    it "destroys the requested tester_stat_sheet" do
#      TesterStatSheet.stub(:find).with("37") { mock_tester_stat_sheet }
#      mock_tester_stat_sheet.should_receive(:destroy)
#      delete :destroy, :id => "37"
#    end
#
#    it "redirects to the tester_stat_sheets list" do
#      TesterStatSheet.stub(:find) { mock_tester_stat_sheet }
#      delete :destroy, :id => "1"
#      response.should redirect_to(tester_stat_sheets_url)
#    end
#  end
end
