require "spec_helper"

describe ForumCategoriesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/forum_categories" }.should route_to(:controller => "forum_categories", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/forum_categories/new" }.should route_to(:controller => "forum_categories", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/forum_categories/1" }.should route_to(:controller => "forum_categories", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/forum_categories/1/edit" }.should route_to(:controller => "forum_categories", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/forum_categories" }.should route_to(:controller => "forum_categories", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/forum_categories/1" }.should route_to(:controller => "forum_categories", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/forum_categories/1" }.should route_to(:controller => "forum_categories", :action => "destroy", :id => "1")
    end

  end
end
