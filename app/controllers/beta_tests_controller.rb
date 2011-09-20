class BetaTestsController < ApplicationController
  access_control do
    allow all, :to => [:index, :show]
    allow :user, :to => [:new, :create]
    allow :developer, :of => :current_beta_test, :to => [:edit, :update]
    allow :admin
  end

  # GET /beta_tests
  def index
    @beta_tests = BetaTest.order(:name).page(params[:page]).per(20)
  end

  # GET /beta_tests/1
  def show
    @beta_test = current_beta_test
  end

  # GET /beta_tests/new
  def new

    @beta_test = BetaTest.new
  end

  # GET /beta_tests/1/edit
  def edit
    @beta_test = current_beta_test
  end

  # POST /beta_tests
  def create
    @beta_test = BetaTest.new(params[:beta_test])
    @beta_test.user = current_user
    if params[:commit] == "cancel"
      redirect_to beta_tests_path
    elsif @beta_test.save
      redirect_to(@beta_test, :notice => 'Betta test was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /beta_tests/1
  def update
    @beta_test = current_beta_test

    if params[:commit] == "cancel"
      redirect_to beta_test_path(@beta_test)

    elsif params[:commit] == "make public"
      @beta_test.open_test
      @beta_test.save!
      render :action => 'edit'

    elsif params[:commit] == "make private"
      @beta_test.close_test
      @beta_test.save!
      render :action => 'edit'

    elsif params[:commit] == "activate"
      @beta_test.activate_test
      @beta_test.save!
      render :action => 'edit'

    elsif params[:commit] == "deactivate"
      @beta_test.deactivate_test
      @beta_test.save!
      render :action => 'edit'

    elsif @beta_test.update_attributes(params[:beta_test])
      redirect_to(@beta_test, :notice => 'Beta test was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /beta_tests/1
  def destroy
    current_beta_test.destroy
    redirect_to beta_tests_path
  end

  def redirect_unsubscribed_developers
    if current_user.has_role?(:developer) && !current_user.has_role?(:subscriber) && !current_user.has_role?(:admin)
      redirect_to subscription_path
    end
  end
end
