require 'spec_helper'

describe "tickets/index.html.erb" do
  before(:each) do
    assign(:tickets, [
      stub_model(Ticket),
      stub_model(Ticket)
    ])
  end

  it "renders a list of tickets" do
    render
  end
end
