require 'spec_helper'

describe "beta_tests/edit.html.erb" do
  before(:each) do
    @beta_test = assign(:beta_test, stub_model(BetaTest))
  end

  it "renders the edit beta_test form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => beta_tests_path(@beta_test), :method => "post" do
    end
  end
end
