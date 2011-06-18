require 'spec_helper'

describe "subscriptions/index.html.erb" do
  before(:each) do
    assign(:subscriptions, [
      stub_model(Subscription),
      stub_model(Subscription)
    ])
  end

  it "renders a list of subscriptions" do
    render
  end
end
