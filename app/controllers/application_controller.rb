#acess helper_methods from tests like: controller.send(:current_user).should == ...
class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Acl9::AccessDenied, ActiveRecord::RecordNotFound, :with => :default_redirect

  helper_method :current_user, :current_beta_test, :current_forum_topic, :current_forum_category, :current_survey, :current_ticket_category, :current_action, :current_controller

  before_filter :clear_beta_test

  protected
  def clear_beta_test
    session[:beta_test] = nil
    session[:forum_category] = nil
    session[:forum_topic] = nil
    session[:survey] = nil
    session[:ticket_category] = nil
  end

  def default_redirect
    if current_user
      if current_user.has_role? :unconfirmed
        redirect_to unconfirmed_user_path
      elsif current_user.has_role? :naughty
        redirect_to suspended_user_path
      else
        redirect_to dashboard_path
      end
    else
      redirect_to sign_up_path
    end
  end
  
  def current_user
    @current_user = User.find(session[:id]) if session[:id]
  end  

  def current_controller
    controller_name
  end

  def current_action
    action_name
  end

  def current_beta_test
    @current_beta_test = nil
    session[:beta_test] ||= params[:beta_test] if params[:beta_test]
    @current_beta_test = BetaTest.find(session[:beta_test]) if session[:beta_test]
    @current_beta_test
  end

  def current_forum_topic
    @current_forum_topic = nil
    @current_forum_topic = ForumTopic.find(session[:forum_topic]) if session[:forum_topic]
  end

  def current_forum_category
    @current_forum_category = nil
    @current_forum_category = ForumCategory.find(session[:forum_category]) if session[:forum_category]
  end

  def current_survey
    @current_survey = nil
    @current_survey = Survey.find(session[:survey]) if session[:survey]
  end

  def current_ticket_category
    @current_ticket_category = nil
    @current_ticket_category = TicketCategory.find(session[:ticket_category]) if session[:ticket_category]
  end

  def involved_only
    if current_forum_category then return current_forum_category.involved_only end
    if current_survey then return current_survey.involved_only end
    if current_ticket_category then return current_ticket_category.involved_only end
  end

  def active_only
    if current_forum_category then return current_forum_category.active_only end
    if current_survey then return current_survey.active_only end
    if current_ticket_category then return current_ticket_category.active_only end
  end

  def activated_only
    if current_forum_category then return current_forum_category.activated_only end
    if current_survey then return current_survey.activated_only end
    if current_ticket_category then return current_ticket_category.activated_only end
  end
end
