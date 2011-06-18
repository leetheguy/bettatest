require 'spec_helper'

describe "ticket_categories/index.html.erb" do
  before(:each) do
    assign(:ticket_categories, [
      stub_model(TicketCategory),
      stub_model(TicketCategory)
    ])
  end

  it "renders a list of ticket_categories" do
    render
  end
end
