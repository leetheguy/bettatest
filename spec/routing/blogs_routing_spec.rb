require "spec_helper"

describe BlogsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/blogs" }.should route_to(:controller => "blogs", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/blogs/new" }.should route_to(:controller => "blogs", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/blogs/1" }.should route_to(:controller => "blogs", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/blogs/1/edit" }.should route_to(:controller => "blogs", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/blogs" }.should route_to(:controller => "blogs", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/blogs/1" }.should route_to(:controller => "blogs", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/blogs/1" }.should route_to(:controller => "blogs", :action => "destroy", :id => "1")
    end

  end
end
