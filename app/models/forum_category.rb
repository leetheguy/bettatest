class ForumCategory < ActiveRecord::Base
  acts_as_authorization_object

	#attr_accessible :name, :description, :access_level          
	
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

  def is_visible_to(user)
    if self.beta_test.open
      visible = true
    else
      visible = false
      if user.has_role?(:admin) || user.has_role?(:developer, self.beta_test)
        visible = true
      else
        tss = self.beta_test.stat_sheet_for(user)
        visible = self.access_level <= tss.level 
      end
    end
    visible
  end
end
