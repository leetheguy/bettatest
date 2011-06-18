require 'spec_helper'

describe "survey_options/new.html.erb" do
  before(:each) do
    assign(:survey_option, stub_model(SurveyOption).as_new_record)
  end

  it "renders new survey_option form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => survey_options_path, :method => "post" do
    end
  end
end
