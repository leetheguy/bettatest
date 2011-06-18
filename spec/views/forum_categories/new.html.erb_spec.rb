require 'spec_helper'

describe "forum_categories/new.html.erb" do
  before(:each) do
    assign(:forum_category, stub_model(ForumCategory).as_new_record)
  end

  it "renders new forum_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forum_categories_path, :method => "post" do
    end
  end
end
