class ForumTopic < ActiveRecord::Base
  acts_as_authorization_object

	attr_accessible :name, :description
	
  validates_presence_of :name
  validates_length_of :name, :maximum => 50
  validates_length_of :description, :maximum => 200
  
  has_many :forum_posts, :dependent => :destroy
  belongs_to :user
  belongs_to :forum_category

  def self.recently_changed(category, count = 5)
    topics = category.forum_topics
    posts = ForumPost.where(:forum_topic_id => topics).order('created_at DESC')
    sorted_topics = ForumTopic.find(posts.map { |p| p.forum_topic_id })[0..5]
    if sorted_topics.count >= 5
      return sorted_topics
    else
      return topics
    end
  end
end
