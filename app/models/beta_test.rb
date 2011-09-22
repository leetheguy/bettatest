class BetaTest < ActiveRecord::Base
  acts_as_authorization_object
  after_create :assign_developer
 
  validates_length_of :name, :maximum => 50
  validates_length_of :description, :maximum => 2000
  validates_numericality_of :max_testers, :starting_points, :active_min_pts, :involved_min_pts, :daily_drop_pts, :daily_login_pts, :forum_post_pts, :rate_up_lose_pts, :rate_up_give_pts, :rate_down_lose_pts, :rate_down_take_pts, :survey_vote_pts, :tester_days_to_gift, :active_days_to_gift, :involved_days_to_gift, :only_integer => true
  validates_presence_of :name
  validates_uniqueness_of :name
  
  belongs_to  :user
  has_and_belongs_to_many :tags
  has_many    :tester_stat_sheets, :dependent => :destroy
  has_many    :users, :through => :tester_stat_sheets
  has_many    :blogs, :dependent => :destroy
  has_many    :forum_categories, :dependent => :destroy
  has_many    :surveys, :dependent => :destroy
  has_many    :ticket_categories, :dependent => :destroy

  def assign_developer
    self.user.has_role! :developer
    self.user.has_role! :developer, self
  end

  def status
    s  = open   ? "public"   : "private"
    s += ", "
    s += active ? "active" : "inactive"
  end

  def open_test
    self.open = true
  end

  def close_test
    self.open = false
  end

  def activate_test
    self.active = true
  end

  def deactivate_test
    self.active = false
  end
end 
