class SurveyOption < ActiveRecord::Base
  acts_as_authorization_object

	attr_accessible :name, :votes
	
  validates_presence_of :name
  validates_length_of :name, :maximum => 50
  
  belongs_to :survey
end
