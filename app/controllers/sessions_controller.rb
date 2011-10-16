class SessionsController < ApplicationController
  access_control do
    allow anonymous,  :to => [:new, :create]
    allow logged_in,  :to => [:destroy]
    allow :admin
  end

  def index
  end

  def possess
    if current_user.has_role? :admin
      session[:id] = params[:user_id]
      redirect_to dashboard_path, :notice => 'Possessed!'
    end
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      user.logged_in!
      session[:id] = user.id
      redirect_to dashboard_path, :notice => "welcome back #{user.name}"
    else
      flash.now.alert = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    session[:id] = nil
    current_user = nil
    redirect_to root_url, :notice => 'Logged out!'
  end
end
