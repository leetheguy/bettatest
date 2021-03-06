class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied, ActiveRecord::RecordNotFound, :with => :default_redirect

  helper_method :current_user, :current_user_is_admin, :current_beta_test, :current_action, :current_controller, :default_redirect, :redirect_non_admin, :current_beta_test_is_open, :current_stat_sheet

  before_filter :current_beta_test, :set_title

  protected

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
    if session[:id] && User.exists?(session[:id])
      @current_user = User.find session[:id]
    else
      @current_user = nil
      session[:id] = nil
    end
    @current_user
  end  

  def current_user_is_admin
    current_user.has_role? :admin
  end  

  def redirect_non_admin
    if !current_user.has_role? :admin
      default_redirect
    end
  end

  def current_controller
    controller_name
  end

  def current_action
    action_name
  end

  def current_beta_test
    if !BetaTest.exists?(session[:bt_id])
      session[:bt_id] = nil
    end
    if current_controller == 'beta_tests'
      if current_action == 'new'
        @current_beta_test = nil
        session[:bt_id] = nil
      elsif params[:id]
        @current_beta_test = BetaTest.find(params[:id])
        TesterStatSheet.visit_adjustment current_user, @current_beta_test
        session[:bt_id] = params[:id]
      elsif session[:bt_id]
        @current_beta_test = BetaTest.find(session[:bt_id])
      else
        @current_beta_test = nil
        session[:bt_id] = nil
      end
    elsif params[:beta_test_id]
      @current_beta_test = BetaTest.find(params[:beta_test_id])
      TesterStatSheet.visit_adjustment current_user, @current_beta_test
      session[:bt_id] = params[:beta_test_id]
    elsif session[:bt_id]
      @current_beta_test = BetaTest.find(session[:bt_id])
    else
      @current_beta_test = nil
      session[:bt_id] = nil
    end
    @current_beta_test
  end

  def current_beta_test_is_open
    current_beta_test.open
  end

  def current_stat_sheet
    if current_beta_test && current_user
      @current_stat_sheet = current_beta_test.stat_sheet_for(current_user)
    else
      @current_stat_sheet = nil
    end
    @current_stat_sheet
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, current_beta_test)
  end

  def set_title
  end
end
