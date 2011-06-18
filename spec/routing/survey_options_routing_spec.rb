require "spec_helper"

describe SurveyOptionsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/survey_options" }.should route_to(:controller => "survey_options", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/survey_options/new" }.should route_to(:controller => "survey_options", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/survey_options/1" }.should route_to(:controller => "survey_options", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/survey_options/1/edit" }.should route_to(:controller => "survey_options", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/survey_options" }.should route_to(:controller => "survey_options", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/survey_options/1" }.should route_to(:controller => "survey_options", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/survey_options/1" }.should route_to(:controller => "survey_options", :action => "destroy", :id => "1")
    end

  end
end
