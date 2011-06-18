class Ticket < ActiveRecord::Base
  acts_as_authorization_object

	attr_accessible :name, :description, :status
	
  validates_length_of :name, :status, :maximum => 50
  validates_length_of :description, :maximum => 200
  validates_presence_of :name, :status
  
  belongs_to :ticket_category
end
