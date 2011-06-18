require 'spec_helper'

describe "survey_options/show.html.erb" do
  before(:each) do
    @survey_option = assign(:survey_option, stub_model(SurveyOption))
  end

  it "renders attributes in <p>" do
    render
  end
end
