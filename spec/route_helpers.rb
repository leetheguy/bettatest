module RouteHelpers
  def self.included(base)
    base.extend(ClassMethods)
  end
    
  module ClassMethods
  end

  def r_beta_test
    BetaTest.first.id
  end

  def r_blog
    @r_blog = Blog.where(:beta_test_id => r_beta_test).first.id
  end

  def r_forum_category
    @r_forum_category = ForumCategory.where(:beta_test_id => r_beta_test).first.id
  end

  def r_forum_topic
    @r_forum_topic = ForumTopic.where(:forum_category_id => r_forum_category).first.id
  end

  def r_forum_post
    @r_forum_post = ForumPost.where(:forum_topic_id => r_forum_topic).first.id
  end

  def r_survey
    @r_survey = Survey.where(:beta_test_id => r_beta_test).first.id
  end

  def r_survey_option
    @r_survey_option = SurveyOption.where(:survey_id => r_survey)
  end

  def r_ticket_category
    bt = BetaTest.first.id
    puts bt
    TicketCategory.where(:beta_test_id => bt).first.id
  end

  def r_ticket
    @r_ticket = Ticket.where(:ticket_category_id => r_ticket_category).first.id
  end

  def r_user
    @r_user = User.first.id
  end

  def r_tester_stat_sheet
    @r_tester_stat_sheet = TesterStatSheet.where(:user_id => r_user).first.id
  end

  def r_subscription
    @r_subscription = Subscription.first.id
  end

  def r_referral
    @r_referral = Referral.first.id
  end
end
