require 'spec_helper'

describe "tester_stat_sheets/new.html.erb" do
  before(:each) do
    assign(:tester_stat_sheet, stub_model(TesterStatSheet).as_new_record)
  end

  it "renders new tester_stat_sheet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tester_stat_sheets_path, :method => "post" do
    end
  end
end
