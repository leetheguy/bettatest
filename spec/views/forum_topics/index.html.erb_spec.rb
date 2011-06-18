require 'spec_helper'

describe "forum_topics/index.html.erb" do
  before(:each) do
    assign(:forum_topics, [
      stub_model(ForumTopic),
      stub_model(ForumTopic)
    ])
  end

  it "renders a list of forum_topics" do
    render
  end
end
