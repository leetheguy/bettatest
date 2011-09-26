require "spec_helper"

describe LeadersController do
  describe "routing" do

    it "routes to #index" do
      get("/leaders").should route_to("leaders#index")
    end

    it "routes to #new" do
      get("/leaders/new").should route_to("leaders#new")
    end

    it "routes to #show" do
      get("/leaders/1").should route_to("leaders#show", :id => "1")
    end

    it "routes to #edit" do
      get("/leaders/1/edit").should route_to("leaders#edit", :id => "1")
    end

    it "routes to #create" do
      post("/leaders").should route_to("leaders#create")
    end

    it "routes to #update" do
      put("/leaders/1").should route_to("leaders#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/leaders/1").should route_to("leaders#destroy", :id => "1")
    end

  end
end
