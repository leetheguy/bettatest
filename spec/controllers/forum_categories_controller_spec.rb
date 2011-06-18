require 'spec_helper'

describe ForumCategoriesController do
  def mock_forum_category(stubs={})
    @mock_forum_category ||= mock_model(ForumCategory, stubs).as_null_object
  end

  before do
    navigate :beta_test => current_beta_test
  end

  specify { cannot_has_access?(approved_deactivated_tester) { get :index } }

  specify { cannot_has_access?(approved_waiting_tester)     { get :index } }

  specify { cannot_has_access?(not_approved_tester)         { get :index } }

  specify { cannot_has_access?(other_developer)             { get :index } }

  specify { can_has_access?(approved_activated_tester)      { get :index } }

  specify { can_has_access?(approved_active_tester)         { get :index } }

  specify { can_has_access?(approved_involved_tester)       { get :index } }

  specify { can_has_access?(same_developer)                 { get :index } }

  describe "GET index" do
    it "assigns all forum categories in current beta test as @forum_categories" do
      login admin
      ForumCategory.stub(:where) { [mock_forum_category(:beta_test => current_beta_test)] }
      get :index
      assigns(:forum_categories).should eq([mock_forum_category])
    end
  end

  describe "GET show" do
    specify { cannot_has_access?(same_developer) { get :show, :id => "42" } }

    it "assigns the requested forum_category as @forum_category" do
      login admin
      ForumCategory.stub(:find).with("37") { mock_forum_category }
      get :show, :id => "37"
      assigns(:forum_category).should be(mock_forum_category)
    end
  end

  describe "GET new" do
    it "assigns a new forum_category as @forum_category" do
      login admin
      ForumCategory.stub(:new) { mock_forum_category }
      get :new
      assigns(:forum_category).should be(mock_forum_category)
    end
  end

  describe "GET edit" do
    it "assigns the requested forum_category as @forum_category" do
      login admin
      ForumCategory.stub(:find).with("37") { mock_forum_category }
      get :edit, :id => "37"
      assigns(:forum_category).should be(mock_forum_category)
    end
  end

  describe "POST create" do
    before do
      login admin
    end

    describe "with valid params" do
      it "assigns a newly created forum_category as @forum_category" do
        ForumCategory.stub(:new).with({'these' => 'params'}) { mock_forum_category(:save => true) }
        post :create, :forum_category => {'these' => 'params'}
        assigns(:forum_category).should be(mock_forum_category)
      end

      it "redirects to the created forum_category" do
        ForumCategory.stub(:new) { mock_forum_category(:save => true) }
        post :create, :forum_category => {}
        response.should redirect_to(forum_category_url(mock_forum_category))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved forum_category as @forum_category" do
        ForumCategory.stub(:new).with({'these' => 'params'}) { mock_forum_category(:save => false) }
        post :create, :forum_category => {'these' => 'params'}
        assigns(:forum_category).should be(mock_forum_category)
      end

      it "re-renders the 'new' template" do
        ForumCategory.stub(:new) { mock_forum_category(:save => false) }
        post :create, :forum_category => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before do
      login admin
    end

    describe "with valid params" do
      it "updates the requested forum_category" do
        ForumCategory.stub(:find).with("37") { mock_forum_category }
        mock_forum_category.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :forum_category => {'these' => 'params'}
      end

      it "assigns the requested forum_category as @forum_category" do
        ForumCategory.stub(:find) { mock_forum_category(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:forum_category).should be(mock_forum_category)
      end

      it "redirects to the forum_category" do
        ForumCategory.stub(:find) { mock_forum_category(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(forum_category_url(mock_forum_category))
      end
    end

    describe "with invalid params" do
      it "assigns the forum_category as @forum_category" do
        ForumCategory.stub(:find) { mock_forum_category(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:forum_category).should be(mock_forum_category)
      end

      it "re-renders the 'edit' template" do
        ForumCategory.stub(:find) { mock_forum_category(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      login admin
    end

    it "destroys the requested forum_category" do
      ForumCategory.stub(:find).with("37") { mock_forum_category }
      mock_forum_category.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the forum_categories list" do
      ForumCategory.stub(:find) { mock_forum_category }
      delete :destroy, :id => "1"
      response.should redirect_to(forum_categories_url)
    end
  end
end
