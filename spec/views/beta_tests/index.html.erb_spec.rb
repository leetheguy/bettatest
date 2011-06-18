require 'spec_helper'

describe "beta_tests/index.html.erb" do
  before(:each) do
    assign(:beta_tests, [
      stub_model(BetaTest),
      stub_model(BetaTest)
    ])
  end

  it "renders a list of beta_tests" do
    render
  end
end
