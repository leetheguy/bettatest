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
    user.has_no_role! :user
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
      self.points = 10
    else
      self.level  = ACTIVATED
      self.points = 10
    end
  end

  def activate_user!
    strip_roles
    self.level = ACTIVATED
    user.has_role! :activated, beta_test
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
          activate_user!
    #TODO send email
        end
        if points < beta_test.active_min_pts
          strip_roles
          user.has_role! :activated, beta_test
        elsif points < beta_test.involved_min_pts
          strip_roles
          user.has_role! :activated, beta_test
          user.has_role! :active,    beta_test
        else
          strip_roles
          user.has_role! :activated, beta_test
          user.has_role! :involved,  beta_test
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
    remove_points! beta_test.rate_up_lose_pts
    other = TesterStatSheet.where("user_id = ? AND beta_test_id = ?", forum_post.user.id, self.beta_test.id).first
    other.add_points! beta_test.rate_up_give_pts
    self.save!
  end

  def forum_rate_down!(forum_post)
    remove_points! beta_test.rate_down_lose_pts
    other = TesterStatSheet.where("user_id = ? AND beta_test_id = ?", forum_post.user.id, self.beta_test.id).first
    other.remove_points! beta_test.rate_down_take_pts
    self.save!
  end

  def survey_vote
    add_points! beta_test.survey_vote_pts
    self.save!
  end

  def add_points!(x)
    self.points += x
    self.save!
  end

  def remove_points!(x)
    self.points -= x
    self.save!
  end

  def promote!
    self.position -= 1
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

  def sheet_for_test(user, test)
    TesterStatSheet.where(:user_id => user).where(:beta_test_id => test).first
  end

end
