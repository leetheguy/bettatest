require 'spec_helper'

describe "forum_posts/new.html.erb" do
  before(:each) do
    assign(:forum_post, stub_model(ForumPost).as_new_record)
  end

  it "renders new forum_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forum_posts_path, :method => "post" do
    end
  end
end
