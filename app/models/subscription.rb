class Subscription < ActiveRecord::Base
  acts_as_authorization_object

	attr_accessible :low_tier_price, :high_tier_price, :low_tier_year_price, :high_tier_year_price, :low_tier_months_left, :high_tier_months_left, :current_tier
	
  belongs_to :user
end
