require 'spec_helper'

describe "referrals/index.html.erb" do
  before(:each) do
    assign(:referrals, [
      stub_model(Referral),
      stub_model(Referral)
    ])
  end

  it "renders a list of referrals" do
    render
  end
end
