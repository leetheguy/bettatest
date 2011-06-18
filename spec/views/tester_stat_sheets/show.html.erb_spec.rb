require 'spec_helper'

describe "tester_stat_sheets/show.html.erb" do
  before(:each) do
    @tester_stat_sheet = assign(:tester_stat_sheet, stub_model(TesterStatSheet))
  end

  it "renders attributes in <p>" do
    render
  end
end
