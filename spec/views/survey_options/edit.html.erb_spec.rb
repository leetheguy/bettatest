require 'spec_helper'

describe "survey_options/edit.html.erb" do
  before(:each) do
    @survey_option = assign(:survey_option, stub_model(SurveyOption))
  end

  it "renders the edit survey_option form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => survey_options_path(@survey_option), :method => "post" do
    end
  end
end
