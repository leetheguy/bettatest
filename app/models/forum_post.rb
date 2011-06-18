class ForumPost < ActiveRecord::Base
  acts_as_authorization_object

	attr_accessible :post
	
	validates_presence_of :post
  
  belongs_to :forum_topic
  belongs_to :user

  def rate_up
    self.score += 1
    self.save!
  end

  def rate_down
    self.score -= 1
    self.save!
  end
end
