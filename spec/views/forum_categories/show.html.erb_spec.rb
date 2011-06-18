require 'spec_helper'

describe "forum_categories/show.html.erb" do
  before(:each) do
    @forum_category = assign(:forum_category, stub_model(ForumCategory))
  end

  it "renders attributes in <p>" do
    render
  end
end
