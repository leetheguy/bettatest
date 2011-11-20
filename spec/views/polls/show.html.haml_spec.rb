require 'spec_helper'

describe "polls/show.html.haml" do
  before(:each) do
    @poll = assign(:poll, stub_model(Poll))
  end

  it "renders attributes in <p>" do
    render
  end
end
