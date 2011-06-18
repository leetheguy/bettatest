require 'spec_helper'

describe "tester_stat_sheets/index.html.erb" do
  before(:each) do
    assign(:tester_stat_sheets, [
      stub_model(TesterStatSheet),
      stub_model(TesterStatSheet)
    ])
  end

  it "renders a list of tester_stat_sheets" do
    render
  end
end
