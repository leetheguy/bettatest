require 'spec_helper'

describe "forum_topics/new.html.erb" do
  before(:each) do
    assign(:forum_topic, stub_model(ForumTopic).as_new_record)
  end

  it "renders new forum_topic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forum_topics_path, :method => "post" do
    end
  end
end
