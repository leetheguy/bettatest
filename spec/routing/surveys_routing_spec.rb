require "spec_helper"

describe SurveysController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/surveys" }.should route_to(:controller => "surveys", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/surveys/new" }.should route_to(:controller => "surveys", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/surveys/1" }.should route_to(:controller => "surveys", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/surveys/1/edit" }.should route_to(:controller => "surveys", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/surveys" }.should route_to(:controller => "surveys", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/surveys/1" }.should route_to(:controller => "surveys", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/surveys/1" }.should route_to(:controller => "surveys", :action => "destroy", :id => "1")
    end

  end
end
