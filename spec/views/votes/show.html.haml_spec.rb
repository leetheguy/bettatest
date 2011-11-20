require 'spec_helper'

describe "votes/show.html.haml" do
  before(:each) do
    @vote = assign(:vote, stub_model(Vote))
  end

  it "renders attributes in <p>" do
    render
  end
end
