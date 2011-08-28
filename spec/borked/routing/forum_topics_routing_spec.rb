require "spec_helper"

describe ForumTopicsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/forum_topics" }.should route_to(:controller => "forum_topics", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/forum_topics/new" }.should route_to(:controller => "forum_topics", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/forum_topics/1" }.should route_to(:controller => "forum_topics", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/forum_topics/1/edit" }.should route_to(:controller => "forum_topics", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/forum_topics" }.should route_to(:controller => "forum_topics", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/forum_topics/1" }.should route_to(:controller => "forum_topics", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/forum_topics/1" }.should route_to(:controller => "forum_topics", :action => "destroy", :id => "1")
    end

  end
end
