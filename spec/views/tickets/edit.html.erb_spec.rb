require 'spec_helper'

describe "tickets/edit.html.erb" do
  before(:each) do
    @ticket = assign(:ticket, stub_model(Ticket))
  end

  it "renders the edit ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tickets_path(@ticket), :method => "post" do
    end
  end
end
