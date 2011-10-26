class TesterStatSheet < ActiveRecord::Base

  acts_as_authorization_object

  DEACTIVATED = -1
  WAITING     =  0
  ACTIVATED   =  1
  ACTIVE      =  2
  INVOLVED    =  3

  before_create :init_sheet
  before_save :adjust_level_and_roles

  validates_numericality_of :level, :only_integer => true, :less_than => 4
  validates_numericality_of :points, :only_integer => true
  validates :user_id, :uniqueness => { :scope => :beta_test_id,
                                       :message => 'not_unique' }
 
  belongs_to :user
  belongs_to :beta_test

  def init_sheet
    user.has_role! :tester
    user.has_role! :tester, beta_test

    sheets = beta_test.tester_stat_sheets
    if sheets.count == 0
      self.position = 1
    else
      self.position = sheets.order(:position).last.position + 1
    end

    if position > beta_test.max_testers
      self.level  = WAITING
    else
      self.level  = ACTIVATED
      user.has_role! :activated, beta_test
    end
    self.points = 10
    self.daily_pts_taken = Date.today
    self.daily_pts_given = Date.today
  end

  def activate_user
    strip_roles
    self.level = ACTIVATED
    user.has_role! :activated, beta_test
    UserMailer.activation_notice(self)
  end

  def activate_user!
    activate_user
    self.save!
  end

  def deactivate_user
    gap_position = position
    strip_roles
    user.has_role! :deactivated,  beta_test
    self.level = DEACTIVATED
    self.position = -1
###TODO send email
    TesterStatSheet.where("beta_test_id = ?", beta_test.id).where("position > ?", gap_position).each do |tss|
      tss.promote!
    end
  end

  def strip_roles
    user.has_no_role! :deactivated, beta_test
    user.has_no_role! :activated,   beta_test
    user.has_no_role! :active,      beta_test
    user.has_no_role! :involved,    beta_test
  end

  def adjust_level_and_roles
    begin TesterStatSheet.find(id)
      if points <= 0
        deactivate_user
      elsif position <= beta_test.max_testers  
        if !user.has_role?(:activated, beta_test)
          activate_user
    #TODO send email
        end
        if points < beta_test.active_min_pts
          strip_roles
          user.has_role! :activated, beta_test
          self.level = ACTIVATED
        elsif points < beta_test.involved_min_pts
          strip_roles
          user.has_role! :activated, beta_test
          user.has_role! :active,    beta_test
          self.level = ACTIVE
        else
          strip_roles
          user.has_role! :activated, beta_test
          user.has_role! :involved,  beta_test
          self.level = INVOLVED
        end
      end
    rescue
    end
  end

  def day_passed!
    remove_points! beta_test.daily_drop_pts
    self.save!
  end

  def logged_in!
    add_points! beta_test.daily_login_pts
    self.save!
  end

  def forum_post!
    add_points! beta_test.forum_post_pts
    self.save!
  end

  def forum_rate_up!(forum_post)
    forum_post.rate_up!
    remove_points! beta_test.rate_up_lose_pts
    other = TesterStatSheet.where("user_id = ? AND beta_test_id = ?", forum_post.user.id, self.beta_test.id).first
    other.add_points! beta_test.rate_up_give_pts
    self.save!
  end

  def forum_rate_down!(forum_post)
    forum_post.rate_down!
    remove_points! beta_test.rate_down_lose_pts
    other = TesterStatSheet.where("user_id = ? AND beta_test_id = ?", forum_post.user.id, self.beta_test.id).first
    other.remove_points! beta_test.rate_down_take_pts
    self.save!
  end

  def survey_vote!
    add_points! beta_test.survey_vote_pts
    self.save!
  end

  def add_points!(x)
    if !points_frozen
      self.points += x
      self.save!
    end
  end

  def remove_points!(x)
    if !points_frozen
      self.points -= x
      self.save!
    end
  end

  def promote
    self.position -= 1
  end

  def promote!
    promote
    self.save!
  end

  def deactivated?
    level == DEACTIVATED
  end

  def waiting?
    level == WAITING
  end

  def activated?
    level == ACTIVATED
  end

  def active?
    level == ACTIVE
  end

  def involved?
    level == INVOLVED
  end

  def sheet_for(user, test)
    test.tester_stat_sheets.where(:user_id => user).first
  end

  def level_to_name
    if self.deactivated?
      "deactivated"
    elsif self.waiting?
      "waiting"
    elsif self.activated?
      "activated"
    elsif self.active?
      "active"
    elsif self.involved?
      "involved"
    else
      "none, how odd"
    end
  end

  def rank
    self.beta_test.tester_stat_sheets.order('points DESC').index(self)
  end

  def self.visit_adjustment(user, test)
    TesterStatSheet.where(:user_id => user, :beta_test => test, :daily_pts_given.lt => Date.today).each do |tss|
      tss.daily_pts_given = Date.today
      tss.add_points! 1
    end
  end

  def self.daily_adjustment
    TesterStatSheet.where(:daily_pts_taken.lt => Date.today, :level.gt => 0).find_each(:batch_size => 200) do |tss|
      tss.daily_pts_taken = Date.today
      tss.remove_points! 1
    end
  end
end
