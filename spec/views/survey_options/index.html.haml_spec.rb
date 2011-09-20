require 'spec_helper'

describe "survey_options/index.html.haml" do
  before(:each) do
    assign(:survey_options, [
      stub_model(SurveyOption),
      stub_model(SurveyOption)
    ])
  end

  it "renders a list of survey_options" do
    render
  end
end
