class UsersController < ApplicationController
  before_filter :assign_edited_user, :only => [:edit, :update]

  access_control do
    #allow :developer, :to => [:index]
    allow all, :to => [:show]
    allow all, :to => [:confirm]
    allow anonymous, :to => [:new, :create]
    allow logged_in, :to => [:edit, :update], :if => :current_user == :edited_user
    deny :naughty, :to => [:edit, :update]
    deny :unconfirmed, :to => [:edit, :update]
    allow :admin
  end

  def confirm
    @user = User.find params[:id]
    code = params[:email_code]
    @user.confirm(code)
    redirect_to @user
  end

  # GET /users
  def index
    redirect_to beta_tests_path
    #if current_user.has_role? :developer
    #  @my_beta_tests = current_user.my_beta_tests
    #end
  end

  # GET /users/1
  def show
    if params[:id]
      @user = User.find params[:id]
    else current_user
      @user = User.find current_user
    end
    if @user
      @beta_tests = @user.my_beta_tests
      @tester_stat_sheets = @user.tester_stat_sheets
    else
      default_redirect
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      session[:id] = @user.id
      redirect_to unconfirmed_user_path, :notice => 'Your account has been successfully created.'
    else
      render :new
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find params[:id]
    @url_for_update = "/users/#{params[:id]}"
  end
  
  # PUT /users/1
  def update
    @user = User.find(params[:id])
    if !@user.confirm_password(@user, params[:password])
      render :edit
    else
      if params[:new_password] != ""
        params[:password] = params[:new_password]
      else
        params[:password_confirmation] = params[:password]
      end
      @user.password = params[:password]
      @user.password_confirmation = params[:password_confirmation]
      @user.betta_email_opt_in = params[:betta_email_opt_in]
      begin @user.save!
        redirect_to dashboard_path, :notice => 'Your preferences have been saved.'
      rescue
        render :edit
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to dashboard_path
  end

  def assign_edited_user
    @edited_user = User.find(params[:id])
  end
end
