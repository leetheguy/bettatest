class Tag < ActiveRecord::Base
  acts_as_authorization_object

	attr_accessible :name
	
	validates_format_of :name, :with => /\A([a-zA-Z\d\-])+\Z/, :message => 'is invalid, only letters, numbers and dashes are allowed'
	validates_length_of :name, :in => 3..15
	validates_presence_of :name
	validates_uniqueness_of :name
	
	has_and_belongs_to_many :beta_tests
end
