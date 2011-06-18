require 'spec_helper'

describe "ticket_categories/new.html.erb" do
  before(:each) do
    assign(:ticket_category, stub_model(TicketCategory).as_new_record)
  end

  it "renders new ticket_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ticket_categories_path, :method => "post" do
    end
  end
end
