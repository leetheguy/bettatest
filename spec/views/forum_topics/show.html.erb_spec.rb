require 'spec_helper'

describe "forum_topics/show.html.erb" do
  before(:each) do
    @forum_topic = assign(:forum_topic, stub_model(ForumTopic))
  end

  it "renders attributes in <p>" do
    render
  end
end
