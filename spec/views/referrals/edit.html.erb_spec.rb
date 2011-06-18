require 'spec_helper'

describe "referrals/edit.html.erb" do
  before(:each) do
    @referral = assign(:referral, stub_model(Referral))
  end

  it "renders the edit referral form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => referrals_path(@referral), :method => "post" do
    end
  end
end
