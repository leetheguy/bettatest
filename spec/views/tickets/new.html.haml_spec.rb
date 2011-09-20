require 'spec_helper'

describe "tickets/new.html.haml" do
  before(:each) do
    assign(:ticket, stub_model(Ticket).as_new_record)
  end

  it "renders new ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tickets_path, :method => "post" do
    end
  end
end
