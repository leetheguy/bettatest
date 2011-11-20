require 'spec_helper'

describe "polls/edit.html.haml" do
  before(:each) do
    @poll = assign(:poll, stub_model(Poll))
  end

  it "renders the edit poll form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => polls_path(@poll), :method => "post" do
    end
  end
end
