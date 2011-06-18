class Session < ActiveRecord::Base
  acts_as_authorization_object

  belongs_to :user

#  before_save :assign_state
#
#  def assign_state
#    if self.user
#      user_is_plain_user
#      if !self.user.email_confirmed
#        user_is_unconfirmed_user
#      elsif self.user.inactive_until != 0
#        user_is_naughty
#      else
#        if self.user.tester_stat_sheets.count > 0
#          user_is_tester
#        end
#        if self.user.my_beta_tests.count > 0
#          user_is_developer
#        end
#        if self.user.is_admin
#          user_is_admin
#        end
#      end
#    end
#  end
#  
#  def user_is_visitor
#    self.unconfirmed_user = false
#    self.naughty = false
#    self.plain_user = false
#    self.tester = false
#    self.developer = false
#    self.admin = false
#    self.visitor = true
#  end
#
#  def user_is_unconfirmed_user
#    self.visitor = false
#    self.naughty = false
#    self.plain_user = false
#    self.tester = false
#    self.developer = false
#    self.admin = false
#    self.unconfirmed_user = true
#  end
#
#  def user_is_naughty
#    self.visitor = false
#    self.unconfirmed_user = false
#    self.plain_user = false
#    self.tester = false
#    self.developer = false
#    self.admin = false
#    self.naughty = true
#  end
#
#  def user_is_plain_user
#    self.visitor = false
#    self.unconfirmed_user = false
#    self.naughty = false
#    self.tester = false
#    self.developer = false
#    self.admin = false
#    self.plain_user = true
#  end
#
#  def user_is_tester
#    self.visitor = false
#    self.unconfirmed_user = false
#    self.naughty = false
#    self.plain_user = false
#    self.tester = true
#  end
#
#  def user_is_developer
#    self.visitor = false
#    self.unconfirmed_user = false
#    self.naughty = false
#    self.plain_user = false
#    self.developer = true
#  end
#
#  def user_is_admin
#    self.visitor = false
#    self.unconfirmed_user = false
#    self.naughty = false
#    self.plain_user = false
#    self.admin = true
#  end
end
