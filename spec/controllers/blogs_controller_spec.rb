require 'spec_helper'

describe BlogsController do
  before do
    developer.has_role! :developer, current_beta_test
  end

  def mock_blog(stubs={})
    @mock_blog ||= mock_model(Blog, stubs).as_null_object
  end

  describe "GET index" do
    describe "allows anyone to view the index" do
      specify { can_has_access?(           ) { get :index } }
      specify { can_has_access?(unconfirmed) { get :index } }
      specify { can_has_access?(naughty    ) { get :index } }
      specify { can_has_access?(user       ) { get :index } }
      specify { can_has_access?(tester     ) { get :index } }
      specify { can_has_access?(developer  ) { get :index } }
    end

    it "assigns all blogs in current beta_test as @blogs" do
      Blog.stub(:where) { [mock_blog(:beta_test => current_beta_test)] }
      get :index, :beta_test => current_beta_test.id
      assigns(:blogs).should eq([mock_blog])
    end
  end

  describe "GET show" do
    describe "allows anyone to view any page" do
      specify { can_has_access?(           ) { get :show, :id => "42" } }
      specify { can_has_access?(unconfirmed) { get :show, :id => "42" } }
      specify { can_has_access?(naughty    ) { get :show, :id => "42" } }
      specify { can_has_access?(user       ) { get :show, :id => "42" } }
      specify { can_has_access?(tester     ) { get :show, :id => "42" } }
      specify { can_has_access?(developer  ) { get :show, :id => "42" } }
    end

    it "assigns the requested blog as @blog" do
      Blog.stub(:find).with("37") { mock_blog }
      get :show, :id => "37"
      assigns(:blog).should be(mock_blog)
    end
  end

  describe "allows developers complete access only to their own blogs" do
    specify { can_has_access?(developer) { get :edit, :id => "42", :beta_test => current_beta_test } }
  end

  describe "GET new" do
    it "assigns a new blog as @blog" do
      login admin
      Blog.stub(:new) { mock_blog }
      get :new, :beta_test => current_beta_test
      assigns(:blog).should be(mock_blog)
    end
  end

  describe "GET edit" do
    it "assigns the requested blog as @blog" do
      login admin
      Blog.stub(:find).with("42") { mock_blog(:beta_test => current_beta_test) }
      get :edit, :id => "42", :beta_test => current_beta_test.id
      assigns(:blog).should be(mock_blog)
    end
  end

  describe "POST create" do
    before do
      login admin
    end

    describe "with valid params" do
      it "assigns a newly created blog as @blog" do
        Blog.stub(:new).with({'these' => 'params'}) { mock_blog(:save => true, :beta_test => current_beta_test) }
        post :create, :blog => {'these' => 'params'}, :beta_test => current_beta_test
        assigns(:blog).should be(mock_blog)
      end

      it "redirects to the created blog" do
        Blog.stub(:new) { mock_blog(:save => true, :beta_test => current_beta_test) }
        post :create, :blog => {}, :beta_test => current_beta_test
        response.should redirect_to(blog_url(mock_blog))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved blog as @blog" do
        Blog.stub(:new).with({'these' => 'params'}) { mock_blog(:save => false, :beta_test => current_beta_test) }
        post :create, :blog => {'these' => 'params'}, :beta_test => current_beta_test
        assigns(:blog).should be(mock_blog)
      end

      it "re-renders the 'new' template" do
        Blog.stub(:new) { mock_blog(:save => false, :beta_test => current_beta_test) }
        post :create, :blog => {}, :beta_test => current_beta_test
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before do
      login admin
    end

    it "redirects cancel button to blogs index" do

    end


    describe "with valid params" do
      it "updates the requested blog" do
        Blog.stub(:find).with("37") { mock_blog(:beta_test => current_beta_test) }
        mock_blog.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :blog => {'these' => 'params'}, :beta_test => current_beta_test
      end

      it "assigns the requested blog as @blog" do
        Blog.stub(:find) { mock_blog(:update_attributes => true, :beta_test => current_beta_test) }
        put :update, :id => "1", :beta_test => current_beta_test
        assigns(:blog).should be(mock_blog)
      end

      it "redirects to the blog" do
        Blog.stub(:find) { mock_blog(:update_attributes => true, :beta_test => current_beta_test) }
        put :update, :id => "1", :beta_test => current_beta_test
        response.should redirect_to(blog_url(mock_blog))
      end
    end

    describe "with invalid params" do
      it "assigns the blog as @blog" do
        Blog.stub(:find) { mock_blog(:update_attributes => false, :beta_test => current_beta_test) }
        put :update, :id => "1", :beta_test => current_beta_test
        assigns(:blog).should be(mock_blog)
      end

      it "re-renders the 'edit' template" do
        Blog.stub(:find) { mock_blog(:update_attributes => false, :beta_test => current_beta_test) }
        put :update, :id => "1", :beta_test => current_beta_test
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      login admin
    end

    it "destroys the requested blog" do
      Blog.stub(:find).with("37") { mock_blog(:beta_test => current_beta_test) }
      mock_blog.should_receive(:destroy)
      delete :destroy, :id => "37", :beta_test => current_beta_test
    end

    it "redirects to the blogs list" do
      Blog.stub(:find) { mock_blog(:beta_test => current_beta_test) }
      delete :destroy, :id => "1", :beta_test => current_beta_test
      response.should redirect_to(blogs_url)
    end
  end
end
