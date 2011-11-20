require 'spec_helper'

describe "polls/new.html.haml" do
  before(:each) do
    assign(:poll, stub_model(Poll).as_new_record)
  end

  it "renders new poll form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => polls_path, :method => "post" do
    end
  end
end
