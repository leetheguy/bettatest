require 'spec_helper'

describe TesterStatSheetsController do
  before do
    developer.has_role! :developer, current_beta_test
  end


  def mock_tester_stat_sheet(stubs={})
    @mock_tester_stat_sheet ||= mock_model(TesterStatSheet, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all tester_stat_sheets as @tester_stat_sheets" do
      TesterStatSheet.stub(:all) { [mock_tester_stat_sheet] }
      get :index
      assigns(:tester_stat_sheets).should eq([mock_tester_stat_sheet])
    end
  end

  describe "GET show" do
    it "assigns the requested tester_stat_sheet as @tester_stat_sheet" do
      TesterStatSheet.stub(:find).with("37") { mock_tester_stat_sheet }
      get :show, :id => "37"
      assigns(:tester_stat_sheet).should be(mock_tester_stat_sheet)
    end
  end

  describe "GET new" do
    it "assigns a new tester_stat_sheet as @tester_stat_sheet" do
      TesterStatSheet.stub(:new) { mock_tester_stat_sheet }
      get :new
      assigns(:tester_stat_sheet).should be(mock_tester_stat_sheet)
    end
  end

  describe "GET edit" do
    it "assigns the requested tester_stat_sheet as @tester_stat_sheet" do
      TesterStatSheet.stub(:find).with("37") { mock_tester_stat_sheet }
      get :edit, :id => "37"
      assigns(:tester_stat_sheet).should be(mock_tester_stat_sheet)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created tester_stat_sheet as @tester_stat_sheet" do
        TesterStatSheet.stub(:new).with({'these' => 'params'}) { mock_tester_stat_sheet(:save => true) }
        post :create, :tester_stat_sheet => {'these' => 'params'}
        assigns(:tester_stat_sheet).should be(mock_tester_stat_sheet)
      end

      it "redirects to the created tester_stat_sheet" do
        TesterStatSheet.stub(:new) { mock_tester_stat_sheet(:save => true) }
        post :create, :tester_stat_sheet => {}
        response.should redirect_to(tester_stat_sheet_url(mock_tester_stat_sheet))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tester_stat_sheet as @tester_stat_sheet" do
        TesterStatSheet.stub(:new).with({'these' => 'params'}) { mock_tester_stat_sheet(:save => false) }
        post :create, :tester_stat_sheet => {'these' => 'params'}
        assigns(:tester_stat_sheet).should be(mock_tester_stat_sheet)
      end

      it "re-renders the 'new' template" do
        TesterStatSheet.stub(:new) { mock_tester_stat_sheet(:save => false) }
        post :create, :tester_stat_sheet => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested tester_stat_sheet" do
        TesterStatSheet.stub(:find).with("37") { mock_tester_stat_sheet }
        mock_tester_stat_sheet.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :tester_stat_sheet => {'these' => 'params'}
      end

      it "assigns the requested tester_stat_sheet as @tester_stat_sheet" do
        TesterStatSheet.stub(:find) { mock_tester_stat_sheet(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:tester_stat_sheet).should be(mock_tester_stat_sheet)
      end

      it "redirects to the tester_stat_sheet" do
        TesterStatSheet.stub(:find) { mock_tester_stat_sheet(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(tester_stat_sheet_url(mock_tester_stat_sheet))
      end
    end

    describe "with invalid params" do
      it "assigns the tester_stat_sheet as @tester_stat_sheet" do
        TesterStatSheet.stub(:find) { mock_tester_stat_sheet(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:tester_stat_sheet).should be(mock_tester_stat_sheet)
      end

      it "re-renders the 'edit' template" do
        TesterStatSheet.stub(:find) { mock_tester_stat_sheet(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested tester_stat_sheet" do
      TesterStatSheet.stub(:find).with("37") { mock_tester_stat_sheet }
      mock_tester_stat_sheet.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the tester_stat_sheets list" do
      TesterStatSheet.stub(:find) { mock_tester_stat_sheet }
      delete :destroy, :id => "1"
      response.should redirect_to(tester_stat_sheets_url)
    end
  end
end
