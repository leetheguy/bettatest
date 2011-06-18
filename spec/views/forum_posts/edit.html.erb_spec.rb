require 'spec_helper'

describe "forum_posts/edit.html.erb" do
  before(:each) do
    @forum_post = assign(:forum_post, stub_model(ForumPost))
  end

  it "renders the edit forum_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forum_posts_path(@forum_post), :method => "post" do
    end
  end
end
