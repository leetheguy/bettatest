require 'spec_helper'

describe "tester_stat_sheets/edit.html.erb" do
  before(:each) do
    @tester_stat_sheet = assign(:tester_stat_sheet, stub_model(TesterStatSheet))
  end

  it "renders the edit tester_stat_sheet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tester_stat_sheets_path(@tester_stat_sheet), :method => "post" do
    end
  end
end
