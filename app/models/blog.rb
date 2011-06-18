class Blog < ActiveRecord::Base
  acts_as_authorization_object

	attr_accessible :name, :post, :draft
	
  validates_presence_of :name, :post
  validates_length_of :name, :maximum => 100
  
  belongs_to :beta_test
end
