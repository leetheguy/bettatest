require "spec_helper"

describe PollsController do
  describe "routing" do

    it "routes to #index" do
      get("/polls").should route_to("polls#index")
    end

    it "routes to #new" do
      get("/polls/new").should route_to("polls#new")
    end

    it "routes to #show" do
      get("/polls/1").should route_to("polls#show", :id => "1")
    end

    it "routes to #edit" do
      get("/polls/1/edit").should route_to("polls#edit", :id => "1")
    end

    it "routes to #create" do
      post("/polls").should route_to("polls#create")
    end

    it "routes to #update" do
      put("/polls/1").should route_to("polls#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/polls/1").should route_to("polls#destroy", :id => "1")
    end

  end
end
