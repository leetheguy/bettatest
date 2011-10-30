class StaticController < ApplicationController
	skip_before_filter :require_login
	def index
		@hide_background = true
	end
	def about
    if params[:page]
      if params[:page] == 'overview'     then render :overview     end
      if params[:page] == 'game'         then render :game         end
      if params[:page] == 'developer'    then render :developer    end
      if params[:page] == 'company'      then render :company      end
      if params[:page] == 'subscription' then render :subscription end
    else
      render :overview
    end
	end
	def contact
    beta_test = BetaTest.where(:name => 'bettatest.com - help desk')
    redirect_to beta_test_path(beta_test_id)
	end
	def unconfirmed_user
	end
	def unconfirmed_user
	end
  def resend_confirmation
    if current_user && current_user.has_role?(:unconfirmed)
      UserMailer.registration_confirmation(current_user).deliver
    end
    redirect_to dashboard_path
  end
end
