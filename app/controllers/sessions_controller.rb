class SessionsController < ApplicationController
  rescue_from Acl9::AccessDenied, :with => :session_redirect

  def session_redirect
    redirect_to root_path
  end

  access_control do
    allow :admin,     :to => [:index]
    allow anonymous,  :to => [:new, :create]
    allow logged_in,  :to => [:destroy]
  end

  def index
  end

	def create
	  user = User.authenticate(params[:email], params[:password])
	  if user
	    session[:id] = user.id
	    redirect_to dashboard_path, :notice => "Logged in!"
	  else
	    flash.now.alert = "Invalid email or password"
	    render "new"
	  end
	end

	def destroy
	  reset_session
	  redirect_to root_url, :notice => "Logged out!"
	end
end
