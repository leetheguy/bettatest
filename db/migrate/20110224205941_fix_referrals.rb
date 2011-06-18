class FixReferrals < ActiveRecord::Migration
  def self.up
  	remove_index	:referrals, :referred_by
  	remove_column	:referrals, :referred_by
  	add_column		:referrals, :referred_by_id, :integer
  	add_index			:referrals, :referred_by_id
  	
  end

  def self.down
  	remove_index	:referrals, :referred_by_id
  	remove_column	:referrals, :referred_by_id
  	add_column		:referrals, :referred_by
  	add_index			:referrals, :referred_by
  end
end
