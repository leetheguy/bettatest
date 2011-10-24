class ForumPost < ActiveRecord::Base
  acts_as_authorization_object

	attr_accessible :post
	
	validates_presence_of :post
  
  after_save :assign_owner

  belongs_to :forum_topic
  belongs_to :user

  def rate_up!
    self.score += 1
    self.save!
  end

  def rate_down!
    self.score -= 1
    self.save!
  end

  def assign_owner
    self.user.has_role!(:owner, self)
  end

  def mama
    self.forum_topic.forum_category
  end
end
