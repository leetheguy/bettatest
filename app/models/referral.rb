class Referral < ActiveRecord::Base
  acts_as_authorization_object

	attr_accessible :referred_by, :reward_at, :rewards_given
	
#	validates_format_of :referred_by, :with => /\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b/, :allow_nil => true
  
  belongs_to :user
  belongs_to :referred_by, :class_name => "User", :foreign_key => "referred_by_id"
end
