require 'spec_helper'

describe "referrals/new.html.erb" do
  before(:each) do
    assign(:referral, stub_model(Referral).as_new_record)
  end

  it "renders new referral form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => referrals_path, :method => "post" do
    end
  end
end
