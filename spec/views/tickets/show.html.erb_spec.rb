require 'spec_helper'

describe "tickets/show.html.erb" do
  before(:each) do
    @ticket = assign(:ticket, stub_model(Ticket))
  end

  it "renders attributes in <p>" do
    render
  end
end
