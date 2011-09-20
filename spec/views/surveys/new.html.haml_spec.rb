require 'spec_helper'

describe "surveys/new.html.haml" do
  before(:each) do
    assign(:survey, stub_model(Survey).as_new_record)
  end

  it "renders new survey form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => surveys_path, :method => "post" do
    end
  end
end
