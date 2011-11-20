require 'spec_helper'

describe "polls/index.html.haml" do
  before(:each) do
    assign(:polls, [
      stub_model(Poll),
      stub_model(Poll)
    ])
  end

  it "renders a list of polls" do
    render
  end
end
