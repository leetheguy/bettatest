require 'spec_helper'

describe SessionsController do
  let!(:user) { Factory.create :user }

  describe "security" do
    it "only allows anonymous visitors" do
      session[:id] = user.id
      get :new
      response.should redirect_to root_url
    end
  end

  describe "GET index" do
    it "allows admins" do
      user.has_role! :admin
      session[:id] = user.id
      get :index
      response.should render_template :index
    end
  end

  describe "GET show" do
  end

  describe "GET new" do
    it "shows the new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    it "redirects non-users" do
      post :create, { :email => "nobody@nobody.foo", :password => "junk_pashword" }
      response.should render_template :new
    end

    it "creates a session for known users" do
      post :create, { :email => user.email.to_param, :password => user.password.to_param }
      session[:id].should == user.id
    end

    it "redirects known users to the dashboard or show user page" do
      post :create, { :email => user.email.to_param, :password => user.password.to_param }
      response.should redirect_to dashboard_path
    end
  end

  describe "DELETE destroy" do
    it "clears the :id from session" do
      session[:id] = user.id
      delete :destroy
      session[:id].should be_nil
    end
  end
end
