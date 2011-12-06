class StaticController < ApplicationController
#  skip_before_filter :require_login

  def index
    @hide_background = true
    if BetaTest.exists?(3)
      bt = BetaTest.find(3)
      if bt.blogs.count > 0
        @blog = bt.blogs.last
      else
    end
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

  def send_contact
    if params[:email] == "" ||  params[:subject] == "" || params[:content] == ""
      flash[:notice] = 'All fields need to be filled in.'
      render :contact
    else
      SiteMailer.send_contact(params[:email], params[:subject], params[:content]).deliver
      flash[:notice] = "Thanks for contacting us. We'll get back to you as soon as possible."
      @hide_background = true
      render :index
    end
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
