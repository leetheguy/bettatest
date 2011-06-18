require 'spec_helper'

describe "referrals/show.html.erb" do
  before(:each) do
    @referral = assign(:referral, stub_model(Referral))
  end

  it "renders attributes in <p>" do
    render
  end
end
