require 'spec_helper'

describe "subscriptions/new.html.haml" do
  before(:each) do
    assign(:subscription, stub_model(Subscription).as_new_record)
  end

  it "renders new subscription form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => subscriptions_path, :method => "post" do
    end
  end
end
