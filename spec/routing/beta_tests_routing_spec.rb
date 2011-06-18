require "spec_helper"

describe BetaTestsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/beta_tests" }.should route_to(:controller => "beta_tests", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/beta_tests/new" }.should route_to(:controller => "beta_tests", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/beta_tests/1" }.should route_to(:controller => "beta_tests", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/beta_tests/1/edit" }.should route_to(:controller => "beta_tests", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/beta_tests" }.should route_to(:controller => "beta_tests", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/beta_tests/1" }.should route_to(:controller => "beta_tests", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/beta_tests/1" }.should route_to(:controller => "beta_tests", :action => "destroy", :id => "1")
    end

  end
end
