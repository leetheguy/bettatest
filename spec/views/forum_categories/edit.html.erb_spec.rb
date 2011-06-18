require 'spec_helper'

describe "forum_categories/edit.html.erb" do
  before(:each) do
    @forum_category = assign(:forum_category, stub_model(ForumCategory))
  end

  it "renders the edit forum_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forum_categories_path(@forum_category), :method => "post" do
    end
  end
end
