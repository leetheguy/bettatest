require 'spec_helper'

describe "votes/index.html.haml" do
  before(:each) do
    assign(:votes, [
      stub_model(Vote),
      stub_model(Vote)
    ])
  end

  it "renders a list of votes" do
    render
  end
end
