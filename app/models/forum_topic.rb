class ForumTopic < ActiveRecord::Base
  acts_as_authorization_object

	attr_accessible :name, :description
	
  validates_presence_of :name
  validates_length_of :name, :maximum => 50
  validates_length_of :description, :maximum => 200
  
  has_many :forum_posts, :dependent => :destroy
  belongs_to :user
  belongs_to :forum_category
end
