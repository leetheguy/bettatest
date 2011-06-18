require 'spec_helper'

describe "forum_categories/index.html.erb" do
  before(:each) do
    assign(:forum_categories, [
      stub_model(ForumCategory),
      stub_model(ForumCategory)
    ])
  end

  it "renders a list of forum_categories" do
    render
  end
end
