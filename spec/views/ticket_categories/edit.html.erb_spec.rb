require 'spec_helper'

describe "ticket_categories/edit.html.erb" do
  before(:each) do
    @ticket_category = assign(:ticket_category, stub_model(TicketCategory))
  end

  it "renders the edit ticket_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ticket_categories_path(@ticket_category), :method => "post" do
    end
  end
end
