require "spec_helper"

describe ReferralsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/referrals" }.should route_to(:controller => "referrals", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/referrals/new" }.should route_to(:controller => "referrals", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/referrals/1" }.should route_to(:controller => "referrals", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/referrals/1/edit" }.should route_to(:controller => "referrals", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/referrals" }.should route_to(:controller => "referrals", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/referrals/1" }.should route_to(:controller => "referrals", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/referrals/1" }.should route_to(:controller => "referrals", :action => "destroy", :id => "1")
    end

  end
end
