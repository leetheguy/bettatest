require "spec_helper"

describe SurveyOptionsController do
  describe "routing" do

    it "routes to #index" do
      get("/survey_options").should route_to("survey_options#index")
    end

    it "routes to #new" do
      get("/survey_options/new").should route_to("survey_options#new")
    end

    it "routes to #show" do
      get("/survey_options/1").should route_to("survey_options#show", :id => "1")
    end

    it "routes to #edit" do
      get("/survey_options/1/edit").should route_to("survey_options#edit", :id => "1")
    end

    it "routes to #create" do
      post("/survey_options").should route_to("survey_options#create")
    end

    it "routes to #update" do
      put("/survey_options/1").should route_to("survey_options#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/survey_options/1").should route_to("survey_options#destroy", :id => "1")
    end

  end
end
