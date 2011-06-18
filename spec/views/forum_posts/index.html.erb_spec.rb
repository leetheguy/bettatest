require 'spec_helper'

describe "forum_posts/index.html.erb" do
  before(:each) do
    assign(:forum_posts, [
      stub_model(ForumPost),
      stub_model(ForumPost)
    ])
  end

  it "renders a list of forum_posts" do
    render
  end
end
