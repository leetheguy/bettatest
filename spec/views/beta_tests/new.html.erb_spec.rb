require 'spec_helper'

describe "beta_tests/new.html.erb" do
  before(:each) do
    assign(:beta_test, stub_model(BetaTest).as_new_record)
  end

  it "renders new beta_test form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => beta_tests_path, :method => "post" do
    end
  end
end
