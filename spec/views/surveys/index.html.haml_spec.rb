require 'spec_helper'

describe "surveys/index.html.haml" do
  before(:each) do
    assign(:surveys, [
      stub_model(Survey),
      stub_model(Survey)
    ])
  end

  it "renders a list of surveys" do
    render
  end
end
