require "spec_helper"

describe StaticController do
  describe "convenience routes" do
    it "sends root to #index" do
      { :get => "" }.should route_to(:controller => "static", :action => "index")
    end
    it "sends about to #about" do
      { :get => "about" }.should route_to(:controller => "static", :action => "about")
    end
    it "sends contact to #contact" do
      { :get => "contact" }.should route_to(:controller => "static", :action => "contact")
    end
  end
end
