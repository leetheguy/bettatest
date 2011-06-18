require 'spec_helper'

describe SurveyOptionsController do

  def mock_survey_option(stubs={})
    @mock_survey_option ||= mock_model(SurveyOption, stubs).as_null_object
  end

  before do
    navigate :beta_test => current_beta_test
  end

  describe "standard survey option security" do
    before do
      navigate :survey => activated_survey
    end

    specify { cannot_has_access?(approved_deactivated_tester) { get :index } }
    specify { cannot_has_access?(approved_waiting_tester)     { get :index } }
    specify { cannot_has_access?(not_approved_tester)         { get :index } }
    specify { cannot_has_access?(other_developer)             { get :index } }
    specify { can_has_access?(same_developer)                 { get :index } }
    specify { can_has_access?(approved_activated_tester)      { get :index } }
    specify { can_has_access?(approved_active_tester)         { get :index } }
    specify { can_has_access?(approved_involved_tester)       { get :index } }
    specify { can_has_access?(approved_activated_tester)      { put :update, :id => "42" } }
    specify { can_has_access?(approved_active_tester)         { put :update, :id => "42" } }
    specify { can_has_access?(approved_involved_tester)       { put :update, :id => "42" } }
  end

  describe "active survey option security" do
    before do
      navigate :survey => active_survey
    end

    specify { cannot_has_access?(approved_activated_tester)   { get :index } }
    specify { can_has_access?(approved_active_tester)         { get :index } }
    specify { can_has_access?(approved_involved_tester)       { get :index } }
    specify { cannot_has_access?(approved_activated_tester)   { put :update, :id => "42" } }
    specify { can_has_access?(approved_active_tester)         { put :update, :id => "42" } }
    specify { can_has_access?(approved_involved_tester)       { put :update, :id => "42" } }
  end

  describe "involved survey option security" do
    before do
      navigate :survey => involved_survey
    end

    specify { cannot_has_access?(approved_activated_tester)   { get :index } }
    specify { cannot_has_access?(approved_active_tester)      { get :index } }
    specify { can_has_access?(approved_involved_tester)       { get :index } }
    specify { cannot_has_access?(approved_activated_tester)   { put :update, :id => "42" } }
    specify { cannot_has_access?(approved_active_tester)      { put :update, :id => "42" } }
    specify { can_has_access?(approved_involved_tester)       { put :update, :id => "42" } }
  end

  describe "GET index" do
    before do
      login admin
      navigate :survey => activated_survey
    end

    it "assigns all survey_options as @survey_options" do
      SurveyOption.stub(:where) { [mock_survey_option(:survey => activated_survey)] }
      get :index
      assigns(:survey_options).should eq([mock_survey_option])
    end
  end

  describe "GET show" do
    before do
      login admin
      navigate :survey => activated_survey
    end

    it "assigns the requested survey_option as @survey_option" do
      SurveyOption.stub(:find).with("37") { mock_survey_option }
      get :show, :id => "37"
      assigns(:survey_option).should be(mock_survey_option)
    end
  end

  describe "GET new" do
    before do
      login admin
      navigate :survey => activated_survey
    end

    it "assigns a new survey_option as @survey_option" do
      SurveyOption.stub(:new) { mock_survey_option }
      get :new
      assigns(:survey_option).should be(mock_survey_option)
    end
  end

  describe "GET edit" do
    before do
      login admin
      navigate :survey => activated_survey
    end

    it "assigns the requested survey_option as @survey_option" do
      SurveyOption.stub(:find).with("37") { mock_survey_option }
      get :edit, :id => "37"
      assigns(:survey_option).should be(mock_survey_option)
    end
  end

  describe "POST create" do
    before do
      login admin
      navigate :survey => activated_survey
    end

    describe "with valid params" do
      it "assigns a newly created survey_option as @survey_option" do
        SurveyOption.stub(:new).with({'these' => 'params'}) { mock_survey_option(:save => true) }
        post :create, :survey_option => {'these' => 'params'}
        assigns(:survey_option).should be(mock_survey_option)
      end

      it "redirects to the created survey_option" do
        SurveyOption.stub(:new) { mock_survey_option(:save => true) }
        post :create, :survey_option => {}
        response.should redirect_to(survey_option_url(mock_survey_option))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved survey_option as @survey_option" do
        SurveyOption.stub(:new).with({'these' => 'params'}) { mock_survey_option(:save => false) }
        post :create, :survey_option => {'these' => 'params'}
        assigns(:survey_option).should be(mock_survey_option)
      end

      it "re-renders the 'new' template" do
        SurveyOption.stub(:new) { mock_survey_option(:save => false) }
        post :create, :survey_option => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before do
      login admin
      navigate :survey => activated_survey
    end

    describe "with valid params" do
      it "updates the requested survey_option" do
        SurveyOption.stub(:find).with("37") { mock_survey_option }
        mock_survey_option.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :survey_option => {'these' => 'params'}
      end

      it "assigns the requested survey_option as @survey_option" do
        SurveyOption.stub(:find) { mock_survey_option(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:survey_option).should be(mock_survey_option)
      end

      it "redirects to the survey_option" do
        SurveyOption.stub(:find) { mock_survey_option(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(survey_option_url(mock_survey_option))
      end
    end

    describe "with invalid params" do
      it "assigns the survey_option as @survey_option" do
        SurveyOption.stub(:find) { mock_survey_option(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:survey_option).should be(mock_survey_option)
      end

      it "re-renders the 'edit' template" do
        SurveyOption.stub(:find) { mock_survey_option(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      login admin
      navigate :survey => activated_survey
    end

    it "destroys the requested survey_option" do
      SurveyOption.stub(:find).with("37") { mock_survey_option }
      mock_survey_option.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the survey_options list" do
      SurveyOption.stub(:find) { mock_survey_option }
      delete :destroy, :id => "1"
      response.should redirect_to(survey_options_url)
    end
  end

end
