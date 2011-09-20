require 'spec_helper'

describe "surveys/edit.html.haml" do
  before(:each) do
    @survey = assign(:survey, stub_model(Survey))
  end

  it "renders the edit survey form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => surveys_path(@survey), :method => "post" do
    end
  end
end
