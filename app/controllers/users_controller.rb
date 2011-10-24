class UsersController < ApplicationController
  load_and_authorize_resource :except => [:show, :update]

  def confirm
    @user = User.find params[:id]
    code = params[:email_code]
    @user.confirm(code)
    redirect_to @user
  end

  # GET /users
  def index
    redirect_to beta_tests_path
  end

  # GET /users/1
  def show
    if params[:id]
      @user = User.find params[:id]
    else current_user
      @user = current_user
    end
    authorize! :show, @user
    @beta_tests = @user.my_beta_tests
    @tester_stat_sheets = @user.tester_stat_sheets
  end

  # GET /users/new
  def new
    #@user = User.new
  end

  # POST /users
  def create
    #@user = User.new(params[:user])
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
    #@user = User.find params[:id]
    @url_for_update = "/users/#{params[:id]}"
  end
  
  # PUT /users/1
  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    if !@user.confirm_password(@user, params[:password])
      render :edit
    else
      att = {}
      att[:betta_email_opt_in] = params[:betta_email_opt_in]
      if params[:new_password] != ""
        att[:password] = params[:new_password]
        att[:password_confirmation] = params[:password_confirmation]
      end
      if @user.update_attributes(att)
        redirect_to dashboard_path, :notice => 'Your preferences have been saved.'
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end
end
