require 'spec_helper'

describe ForumPostsController do
  def mock_forum_post(stubs={})
    @mock_forum_post ||= mock_model(ForumPost, stubs).as_null_object
  end

  def mock_forum_topic(stubs={})
    @mock_forum_topic ||= mock_model(ForumTopic, stubs).as_null_object
  end

  before do
    navigate :beta_test => current_beta_test
  end

  describe "standard forum category security" do
    before do
      navigate :forum_category => activated_forum_category,
               :forum_topic => activated_forum_topic
    end

    specify { cannot_has_access?(approved_deactivated_tester) { get :index } }
    specify { cannot_has_access?(approved_waiting_tester)     { get :index } }
    specify { cannot_has_access?(not_approved_tester)         { get :index } }
    specify { cannot_has_access?(other_developer)             { get :index } }
    specify { can_has_access?(approved_activated_tester)      { get :index } }
    specify { can_has_access?(approved_active_tester)         { get :index } }
    specify { can_has_access?(approved_involved_tester)       { get :index } }
    specify { can_has_access?(same_developer)                 { get :index } }
  end

  describe "active forum category security" do
    before do
      navigate :forum_category => active_forum_category,
               :forum_topic => activated_forum_topic
    end

    specify { cannot_has_access?(approved_activated_tester)   { get :index } }
    specify { can_has_access?(approved_active_tester)         { get :index } }
    specify { can_has_access?(approved_involved_tester)       { get :index } }
  end

  describe "involved forum category security" do
    before do
      navigate :forum_category => involved_forum_category,
               :forum_topic => activated_forum_topic
    end

    specify { cannot_has_access?(approved_activated_tester)   { get :index } }
    specify { cannot_has_access?(approved_active_tester)      { get :index } }
    specify { can_has_access?(approved_involved_tester)       { get :index } }
  end

  describe "other security" do
    it "lets users edit their own posts"
  end

  describe "GET rate_up" do
    it "rates up the current post"
  end

  describe "GET rate_down" do
    it "rates down the current post"
  end

  describe "GET index" do
    before do
      login admin
      navigate :forum_category => activated_forum_category,
               :forum_topic => activated_forum_topic
    end

    it "assigns all forum_posts as @forum_posts" #do
#      ForumPost.stub(:where) { [mock_forum_post(:forum_topic => activated_forum_topic)] }
#      get :index
#      assigns(:forum_posts).should eq([mock_forum_post])
#    end
  end

  describe "GET show" do
    it "just redirects"# do
#      get :show
#      response.should be_redirect
#    end

    before do
      login admin
      navigate :forum_category => activated_forum_category,
               :forum_topic => activated_forum_topic
    end

    it "assigns the requested forum_post as @forum_post" do
      ForumPost.stub(:find).with("37") { mock_forum_post }
      get :show, :id => "37"
      assigns(:forum_post).should be(mock_forum_post)
    end
  end

  describe "GET new" do
    before do
      login admin
      navigate :forum_category => activated_forum_category,
               :forum_topic => activated_forum_topic
    end

    it "assigns a new forum_post as @forum_post" do
      ForumTopic.stub(:find) { mock_forum_topic }
      ForumPost.stub(:new) { mock_forum_post }
      get :new
      assigns(:forum_post).should be(mock_forum_post)
    end
  end

  describe "GET edit" do
    before do
      login admin
      navigate :forum_category => activated_forum_category,
               :forum_topic => activated_forum_topic
    end

    it "assigns the requested forum_post as @forum_post" do
      ForumPost.stub(:find).with("37") { mock_forum_post }
      get :edit, :id => "37"
      assigns(:forum_post).should be(mock_forum_post)
    end
  end

  describe "POST create" do
    before do
      login admin
      navigate :forum_category => activated_forum_category,
               :forum_topic => activated_forum_topic
    end

    describe "with valid params" do
      it "assigns a newly created forum_post as @forum_post" do
        ForumPost.stub(:new).with({'these' => 'params'}) { mock_forum_post(:save => true) }
        post :create, :forum_post => {'these' => 'params'}
        assigns(:forum_post).should be(mock_forum_post)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved forum_post as @forum_post" do
        ForumPost.stub(:new).with({'these' => 'params'}) { mock_forum_post(:save => false) }
        post :create, :forum_post => {'these' => 'params'}
        assigns(:forum_post).should be(mock_forum_post)
      end

      it "re-renders the 'new' template" do
        ForumPost.stub(:new) { mock_forum_post(:save => false) }
        post :create, :forum_post => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before do
      login admin
      navigate :forum_category => activated_forum_category,
               :forum_topic => activated_forum_topic
    end

    describe "with valid params" do
      it "updates the requested forum_post" do
        ForumPost.stub(:find).with("37") { mock_forum_post }
        mock_forum_post.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :forum_post => {'these' => 'params'}
      end

      it "assigns the requested forum_post as @forum_post" do
        ForumPost.stub(:find) { mock_forum_post(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:forum_post).should be(mock_forum_post)
      end
    end

    describe "with invalid params" do
      it "assigns the forum_post as @forum_post" do
        ForumPost.stub(:find) { mock_forum_post(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:forum_post).should be(mock_forum_post)
      end

      it "re-renders the 'edit' template" do
        ForumPost.stub(:find) { mock_forum_post(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      login admin
      navigate :forum_category => activated_forum_category,
               :forum_topic => activated_forum_topic
    end

    it "destroys the requested forum_post" do
      ForumPost.stub(:find).with("37") { mock_forum_post }
      mock_forum_post.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  end

end
