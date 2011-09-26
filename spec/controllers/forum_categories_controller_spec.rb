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
    it "only assigns viewable categories to @forum_categories"
    it "assigns all forum categories in current beta test as @forum_categories" do
      login admin
      ForumCategory.stub(:categories_for) { [mock_forum_category(:beta_test => current_beta_test)] }
      get :index, :bt_id => '1'
      assigns(:forum_categories).should eq([mock_forum_category])
    end
  end

  describe "GET show" do
    it "only assigns viewable categories to @forum_categories"
    specify { cannot_has_access?(same_developer) { get :show, :id => "42" } }

    it "assigns the requested forum_category as @forum_category" do
      login admin
      ForumCategory.stub(:categories_for) { [mock_forum_category(:beta_test => current_beta_test)] }
      ForumCategory.stub(:find).with("37") { mock_forum_category }
      get :show, :id => "37", :bt_id => '1'
      assigns(:forum_category).should be(mock_forum_category)
    end
  end

  describe "GET new" do
    it "assigns a new forum_category as @forum_category" do
      login admin
      ForumCategory.stub(:new) { mock_forum_category }
      get :new, :bt_id => '1'
      assigns(:forum_category).should be(mock_forum_category)
    end
  end

  describe "GET edit" do
    it "assigns the requested forum_category as @forum_category" do
      login admin
      ForumCategory.stub(:find).with("37") { mock_forum_category }
      get :edit, :id => "37", :bt_id => '1'
      assigns(:forum_category).should be(mock_forum_category)
    end
  end

  describe "POST create" do
    before do
      login admin
    end

    describe "with valid params" do
      it "assigns a newly created forum_category as @forum_category" do
        ForumCategory.stub(:new).with({'these' => 'params'}) { mock_forum_category(:save => true)}
        post :create, :forum_category => {'these' => 'params'}, :bt_id => current_beta_test.id
        assigns(:forum_category).should be(mock_forum_category)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved forum_category as @forum_category" do
        ForumCategory.stub(:new).with({'these' => 'params'}) { mock_forum_category(:save => false, :beta_test => current_beta_test) }
        post :create, :forum_category => {'these' => 'params'}, :bt_id => current_beta_test.id
        assigns(:forum_category).should be(mock_forum_category)
      end

      it "re-renders the 'new' template" do
        ForumCategory.stub(:new) { mock_forum_category(:save => false) }
        post :create, :forum_category => {}, :bt_id => '1'
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
        put :update, :id => "37", :forum_category => {'these' => 'params'}, :bt_id => '1'
      end

      it "assigns the requested forum_category as @forum_category" do
        ForumCategory.stub(:find) { mock_forum_category(:update_attributes => true) }
        put :update, :id => "1", :bt_id => current_beta_test.id
        assigns(:forum_category).should be(mock_forum_category)
      end
    end

    describe "with invalid params" do
      it "assigns the forum_category as @forum_category" do
        ForumCategory.stub(:find) { mock_forum_category(:update_attributes => false) }
        put :update, :id => "1", :bt_id => current_beta_test.id
        assigns(:forum_category).should be(mock_forum_category)
      end

      it "re-renders the 'edit' template" do
        ForumCategory.stub(:find) { mock_forum_category(:update_attributes => false) }
        put :update, :id => "1", :bt_id => current_beta_test.id
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "only assigns viewable categories to @forum_categories"
    it "destroys the requested forum_category" do
      login admin
      ForumCategory.stub(:categories_for) { [mock_forum_category(:beta_test => current_beta_test)] }
      ForumCategory.stub(:find).with("37") { mock_forum_category }
      mock_forum_category.should_receive(:destroy)
      delete :destroy, :id => "37", :bt_id => current_beta_test.id
    end
  end
end
