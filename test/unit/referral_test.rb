require 'test_helper'

class ReferralTest < ActiveSupport::TestCase
  setup do
   @ref = Factory.build :referral
  end

  test "referrer has a valid email" do
#    invalid_referrer_email = Factory.build :referral, :referred_by => 'invalid.email'
#    assert invalid_referrer_email.valid?, invalid_referrer_email.errors.to_s
  end
end
