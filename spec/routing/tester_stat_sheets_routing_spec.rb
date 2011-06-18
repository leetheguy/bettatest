require "spec_helper"

describe TesterStatSheetsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/tester_stat_sheets" }.should route_to(:controller => "tester_stat_sheets", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/tester_stat_sheets/new" }.should route_to(:controller => "tester_stat_sheets", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/tester_stat_sheets/1" }.should route_to(:controller => "tester_stat_sheets", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/tester_stat_sheets/1/edit" }.should route_to(:controller => "tester_stat_sheets", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/tester_stat_sheets" }.should route_to(:controller => "tester_stat_sheets", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/tester_stat_sheets/1" }.should route_to(:controller => "tester_stat_sheets", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/tester_stat_sheets/1" }.should route_to(:controller => "tester_stat_sheets", :action => "destroy", :id => "1")
    end

  end
end
