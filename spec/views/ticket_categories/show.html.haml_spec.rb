require 'spec_helper'

describe "ticket_categories/show.html.haml" do
  before(:each) do
    @ticket_category = assign(:ticket_category, stub_model(TicketCategory))
  end

  it "renders attributes in <p>" do
    render
  end
end
