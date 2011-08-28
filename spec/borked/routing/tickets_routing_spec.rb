require "spec_helper"

describe TicketsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/beta_tests/1/ticket_categories/1/tickets" }.should route_to(:controller => "tickets", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/beta_tests/1/ticket_categories/1/tickets/new" }.should route_to(:controller => "tickets", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "beta_test/1/ticket_category/1/tickets/1" }.should route_to(:controller => "tickets", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "beta_test/1/ticket_category/1/tickets/1/edit" }.should route_to(:controller => "tickets", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "beta_test/ticket_category/1/1/tickets" }.should route_to(:controller => "tickets", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "beta_test/1/ticket_category/1/tickets/1" }.should route_to(:controller => "tickets", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/beta_tests/1/ticket_categories/1/tickets/1" }.should route_to(:controller => "tickets", :action => "destroy", :id => "1")
    end

  end
end
