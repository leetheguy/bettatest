require "spec_helper"

describe ForumPostsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/forum_posts" }.should route_to(:controller => "forum_posts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/forum_posts/new" }.should route_to(:controller => "forum_posts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/forum_posts/1" }.should route_to(:controller => "forum_posts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/forum_posts/1/edit" }.should route_to(:controller => "forum_posts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/forum_posts" }.should route_to(:controller => "forum_posts", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/forum_posts/1" }.should route_to(:controller => "forum_posts", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/forum_posts/1" }.should route_to(:controller => "forum_posts", :action => "destroy", :id => "1")
    end

  end
end
