require 'spec_helper'

describe ForumTopicsController do
  def mock_forum_topic(stubs={})
    @mock_forum_topic ||= mock_model(ForumTopic, stubs).as_null_object
  end

  before do
    navigate :beta_test => current_beta_test
  end

  describe "standard forum category security" do
    before do
      navigate :forum_category => activated_forum_category
    end

    specify { cannot_has_access?(approved_deactivated_tester) { get :index } }
    specify { cannot_has_access?(approved_waiting_tester)     { get :index } }
    specify { cannot_has_access?(not_approved_tester)         { get :index } }
    specify { cannot_has_access?(other_developer)             { get :index } }
    specify { can_has_access?(same_developer)                 { get :index } }
    specify { can_has_access?(approved_activated_tester)      { get :index } }
    specify { can_has_access?(approved_active_tester)         { get :index } }
    specify { can_has_access?(approved_involved_tester)       { get :index } }
  end

  describe "active forum category security" do
    before do
      navigate :forum_category => active_forum_category
    end

    specify { cannot_has_access?(approved_activated_tester)   { get :index } }
    specify { can_has_access?(approved_active_tester)         { get :index } }
    specify { can_has_access?(approved_involved_tester)       { get :index } }
  end

  describe "involved forum category security" do
    before do
      navigate :forum_category => involved_forum_category
    end

    specify { cannot_has_access?(approved_activated_tester)   { get :index } }
    specify { cannot_has_access?(approved_active_tester)      { get :index } }
    specify { can_has_access?(approved_involved_tester)       { get :index } }
  end

  describe "GET index" do
    before do
      login admin
      navigate :forum_category => activated_forum_category
    end

    it "assigns all forum_topics in curent category as @forum_topics" do
      ForumTopic.stub(:where) { [mock_forum_topic(:beta_test => current_beta_test, :forum_category => activated_forum_category)] }
      get :index
      assigns(:forum_topics).should eq([mock_forum_topic])
    end
  end

  describe "GET show" do
    before do
      login admin
      navigate :forum_category => activated_forum_category
    end

    specify { cannot_has_access?(same_developer) { get :show, :id => "42" } }
    it "assigns the requested forum_topic as @forum_topic" do
      ForumTopic.stub(:find).with("37") { mock_forum_topic }
      get :show, :id => "37"
      assigns(:forum_topic).should be(mock_forum_topic)
    end
  end

  describe "GET new" do
    before do
      login admin
      navigate :forum_category => activated_forum_category
    end

    it "assigns a new forum_topic as @forum_topic" do
      ForumTopic.stub(:new) { mock_forum_topic }
      get :new
      assigns(:forum_topic).should be(mock_forum_topic)
    end
  end

  describe "GET edit" do
    before do
      login admin
      navigate :forum_category => activated_forum_category
    end

    it "assigns the requested forum_topic as @forum_topic" do
      ForumTopic.stub(:find).with("37") { mock_forum_topic }
      get :edit, :id => "37"
      assigns(:forum_topic).should be(mock_forum_topic)
    end
  end

  describe "POST create" do
    before do
      login admin
      navigate :forum_category => activated_forum_category
    end

    describe "with valid params" do
      it "assigns a newly created forum_topic as @forum_topic" do
        ForumTopic.stub(:new).with({'these' => 'params'}) { mock_forum_topic(:save => true) }
        post :create, :forum_topic => {'these' => 'params'}
        assigns(:forum_topic).should be(mock_forum_topic)
      end

      it "redirects to the created forum_topic" do
        ForumTopic.stub(:new) { mock_forum_topic(:save => true) }
        post :create, :forum_topic => {}
        response.should redirect_to(forum_topic_url(mock_forum_topic))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved forum_topic as @forum_topic" do
        ForumTopic.stub(:new).with({'these' => 'params'}) { mock_forum_topic(:save => false) }
        post :create, :forum_topic => {'these' => 'params'}
        assigns(:forum_topic).should be(mock_forum_topic)
      end

      it "re-renders the 'new' template" do
        ForumTopic.stub(:new) { mock_forum_topic(:save => false) }
        post :create, :forum_topic => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before do
      login admin
      navigate :forum_category => activated_forum_category
    end

    describe "with valid params" do
      it "updates the requested forum_topic" do
        ForumTopic.stub(:find).with("37") { mock_forum_topic }
        mock_forum_topic.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :forum_topic => {'these' => 'params'}
      end

      it "assigns the requested forum_topic as @forum_topic" do
        ForumTopic.stub(:find) { mock_forum_topic(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:forum_topic).should be(mock_forum_topic)
      end

      it "redirects to the forum_topic" do
        ForumTopic.stub(:find) { mock_forum_topic(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(forum_topic_url(mock_forum_topic))
      end
    end

    describe "with invalid params" do
      it "assigns the forum_topic as @forum_topic" do
        ForumTopic.stub(:find) { mock_forum_topic(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:forum_topic).should be(mock_forum_topic)
      end

      it "re-renders the 'edit' template" do
        ForumTopic.stub(:find) { mock_forum_topic(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      login admin
      navigate :forum_category => activated_forum_category
    end

    it "destroys the requested forum_topic" do
      ForumTopic.stub(:find).with("37") { mock_forum_topic }
      mock_forum_topic.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the forum_topics list" do
      ForumTopic.stub(:find) { mock_forum_topic }
      delete :destroy, :id => "1"
      response.should redirect_to(forum_topics_url)
    end
  end
end
