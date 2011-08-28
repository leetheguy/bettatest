require "spec_helper"

describe TicketCategoriesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/ticket_categories" }.should route_to(:controller => "ticket_categories", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/ticket_categories/new" }.should route_to(:controller => "ticket_categories", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/ticket_categories/1" }.should route_to(:controller => "ticket_categories", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/ticket_categories/1/edit" }.should route_to(:controller => "ticket_categories", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/ticket_categories" }.should route_to(:controller => "ticket_categories", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/ticket_categories/1" }.should route_to(:controller => "ticket_categories", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/ticket_categories/1" }.should route_to(:controller => "ticket_categories", :action => "destroy", :id => "1")
    end

  end
end
