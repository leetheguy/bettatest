class StaticController < ApplicationController
	skip_before_filter :require_login
	def index
		@hide_background = true
	end
	def about
	end
	def contact
	end
	def unconfirmed_user
	end
	def unconfirmed_user
	end
  def resend_confirmation
    if current_user && current_user.has_role(:unconfirmed)
      UserMailer.registration_confirmation(current_user).deliver
    end
    redirect_to dashboard_path
  end
end
