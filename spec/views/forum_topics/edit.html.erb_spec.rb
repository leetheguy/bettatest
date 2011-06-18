require 'spec_helper'

describe "forum_topics/edit.html.erb" do
  before(:each) do
    @forum_topic = assign(:forum_topic, stub_model(ForumTopic))
  end

  it "renders the edit forum_topic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forum_topics_path(@forum_topic), :method => "post" do
    end
  end
end
