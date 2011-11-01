class StaticController < ApplicationController
#  skip_before_filter :require_login


  def index
    @hide_background = true
  end

  def about
    if params[:page]
      if params[:page] == 'overview'
        @title = 'overview'
        render :overview
      end
      if params[:page] == 'game'
        @title = 'game info'
        render :game
      end
      if params[:page] == 'developer'
        @title = 'developer info'
        render :developer
      end
      if params[:page] == 'company'
        @title = 'company info'
        render :company
      end
      if params[:page] == 'subscription'
        @title = 'subscription info'
        render :subscription
      end
    else
      @title = 'overview'
      render :overview
    end
  end

  def contact
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
