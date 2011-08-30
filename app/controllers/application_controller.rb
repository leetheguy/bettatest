#access helper_methods from tests like: controller.send(:current_user).should == ...
class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Acl9::AccessDenied, ActiveRecord::RecordNotFound, :with => :default_redirect

  helper_method :current_user, :current_beta_test, :current_forum_topic, :current_forum_category, :current_survey, :current_ticket_category, :current_action, :current_controller

  before_filter :debug

  protected

  def debug
    puts params.to_s
    puts current_controller
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

  def current_user_is_admin
    @current_user.has_role? :admin
  end  

  def current_controller
    controller_name
  end

  def current_action
    action_name
  end

  def current_beta_test
    @current_beta_test = BetaTest.find(params[:bt_id])
  end
end
