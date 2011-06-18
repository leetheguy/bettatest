require 'spec_helper'

describe "forum_posts/show.html.erb" do
  before(:each) do
    @forum_post = assign(:forum_post, stub_model(ForumPost))
  end

  it "renders attributes in <p>" do
    render
  end
end
