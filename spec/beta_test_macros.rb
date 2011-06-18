module BetaTestMacros
  def self.included(base)
    base.extend(ClassMethods)
  end
    
  module ClassMethods
  end

  def navigate(session_hash)
    session[:beta_test] ||= session_hash[:beta_test] || nil
    session[:forum_category] ||= session_hash[:forum_category] || nil
    session[:forum_topic] ||= session_hash[:forum_topic] || nil
    session[:survey] ||= session_hash[:survey] || nil
    session[:ticket_category] ||= session_hash[:ticket_category] || nil
  end

  def current_beta_test
    if !@current_beta_test
      @current_beta_test = Factory.create :beta_test
    end
    @current_beta_test
  end

  def other_beta_test
    if !@other_beta_test
      @other_beta_test = Factory.create :beta_test
    end
    @other_beta_test
  end

  def activated_forum_category
    if !@activated_forum_category
      @activated_forum_category = Factory.create :forum_category, :beta_test => current_beta_test
    end
    @activated_forum_category
  end

  def active_forum_category
    if !@active_forum_category
      @active_forum_category = Factory.create :forum_category, :access_level => ForumCategory.active, :beta_test => current_beta_test
    end
    @active_forum_category
  end

  def involved_forum_category
    if !@involved_forum_category
      @involved_forum_category = Factory.create :forum_category, :access_level => ForumCategory.involved, :beta_test => current_beta_test
    end
    @involved_forum_category
  end

  def activated_forum_topic
    if !@activated_forum_topic
      @activated_forum_topic = Factory.create :forum_topic, :forum_category => activated_forum_category
    end
    @activated_forum_topic
  end

  def activated_survey
    if !@activated_survey
      @activated_survey = Factory.create :survey, :beta_test => current_beta_test, :access_level => Survey.activated
    end
    @activated_survey
  end

  def active_survey
    if !@active_survey
      @active_survey = Factory.create :survey, :beta_test => current_beta_test, :access_level => Survey.active
    end
    @active_survey
  end

  def involved_survey
    if !@involved_survey
      @involved_survey = Factory.create :survey, :beta_test => current_beta_test, :access_level => Survey.involved
    end
    @involved_survey
  end

  def current_ticket_category
    if !@current_ticket_category
      @current_ticket_category= Factory.create :ticket_category
    end
    @current_ticket_category
  end

  def not_approved_tester
    if !@not_approved_tester
      @not_approved_tester = Factory.create :tester
      @not_approved_tester.has_no_roles!
      @not_approved_tester.has_role! :tester
    end
    @not_approved_tester
  end

  def approved_deactivated_tester
    if !@approved_deactivated_tester
      @approved_deactivated_tester = Factory.create :tester
      @approved_deactivated_tester.has_no_roles!
      @approved_deactivated_tester.has_role! :tester
      @approved_deactivated_tester.has_role! :tester, current_beta_test
      @approved_deactivated_tester.has_role! :deactivated, current_beta_test
    end
    @approved_deactivated_tester
  end

  def approved_waiting_tester
    if !@approved_waiting_tester
      @approved_waiting_tester = Factory.create :tester
      @approved_waiting_tester.has_no_roles!
      @approved_waiting_tester.has_role! :tester
      @approved_waiting_tester.has_role! :tester, current_beta_test
      @approved_waiting_tester.has_role! :waiting, current_beta_test
    end
    @approved_waiting_tester
  end

  def approved_activated_tester
    if !@approved_activated_tester
      @approved_activated_tester = Factory.create :tester
      @approved_activated_tester.has_no_roles!
      @approved_activated_tester.has_role! :tester
      @approved_activated_tester.has_role! :tester, current_beta_test
      @approved_activated_tester.has_role! :activated, current_beta_test
    end
    @approved_activated_tester
  end

  def approved_active_tester
    if !@approved_active_tester
      @approved_active_tester = Factory.create :tester
      @approved_active_tester.has_no_roles!
      @approved_active_tester.has_role! :tester
      @approved_active_tester.has_role! :tester, current_beta_test
      @approved_active_tester.has_role! :activated, current_beta_test
      @approved_active_tester.has_role! :active, current_beta_test
    end
    @approved_active_tester
  end

  def approved_involved_tester
    if !@approved_involved_tester
      @approved_involved_tester = Factory.create :tester
      @approved_involved_tester.has_no_roles!
      @approved_involved_tester.has_role! :tester
      @approved_involved_tester.has_role! :tester, current_beta_test
      @approved_involved_tester.has_role! :activated, current_beta_test
      @approved_involved_tester.has_role! :involved, current_beta_test
    end
    @approved_involved_tester
  end

  def same_developer
    if !@same_developer
      @same_developer = Factory.create :developer
      @same_developer.has_no_roles!
      @same_developer.has_role! :developer
      @same_developer.has_role! :developer, current_beta_test
    end
    @same_developer
  end

  def other_developer
    if !@other_developer
      @other_developer = Factory.create :developer
      @other_developer.has_no_roles!
      @other_developer.has_role! :developer
      @other_developer.has_role! :developer, other_beta_test
    end
    @other_developer
  end
end
