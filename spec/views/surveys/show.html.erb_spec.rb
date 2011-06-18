require 'spec_helper'

describe "surveys/show.html.erb" do
  before(:each) do
    @survey = assign(:survey, stub_model(Survey))
  end

  it "renders attributes in <p>" do
    render
  end
end
