class ForumCategory < ActiveRecord::Base
  acts_as_authorization_object

	attr_accessible :name, :description, :access_level          
	
	validates_length_of :name, :maximum => 50
	validates_length_of :description, :maximum => 200
	validates_numericality_of :access_level, :only_integer => true, :greater_than => 0, :less_than => 4
  validates_presence_of :name
  
  belongs_to :beta_test
  has_many :forum_topics, :dependent => :destroy

  def involved_only
    self.access_level == 3
  end

  def active_only
    self.access_level == 2
  end

  def activated_only
    self.access_level == 1
  end

  def ForumCategory.involved
    3
  end

  def ForumCategory.active
    2
  end
  
  def ForumCategory.activated
    1
  end

  def access_level_name
    if access_level == 1
      "all members"
    elsif access_level == 2
      "active and involved members"
    elsif access_level == 3
      "involved members only"
    end
  end

  def self.categories_for(user, beta_test)
    if user.has_role? :admin
      ForumCategory.where(:beta_test_id => beta_test.id)
    else
      tss = TesterStatSheet.where(:beta_test_id => beta_test.id, 
                                    :user_id => user.id).first
      if tss
        ForumCategory.where('access_level < ?', tss.level)
      end
    end
  end
end
