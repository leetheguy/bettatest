require 'spec_helper'

describe "subscriptions/show.html.haml" do
  before(:each) do
    @subscription = assign(:subscription, stub_model(Subscription))
  end

  it "renders attributes in <p>" do
    render
  end
end
