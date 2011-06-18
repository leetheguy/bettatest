class BetaTestsController < ApplicationController
  before_filter :load_beta_test, :only => [:edit, :update]

  access_control do
    allow all, :to => [:index, :show]
    allow :user, :tester, :subscriber, :to => [:new, :create]
    allow :developer, :of => :beta_test, :to => [:edit, :update]
    allow :admin
  end

  # GET /beta_tests
  def index
    @beta_tests = BetaTest.order(:name).page(params[:page]).per(20)
  end

  # GET /beta_tests/1
  def show
    @beta_test = BetaTest.find(params[:id])
  end

  # GET /beta_tests/new
  def new
    @beta_test = BetaTest.new
  end

  # GET /beta_tests/1/edit
  def edit
    @beta_test = BetaTest.find(params[:id])
  end

  # POST /beta_tests
  def create
    @beta_test = BetaTest.new(params[:beta_test])
    @beta_test.user = current_user
    if @beta_test.save
      redirect_to(@beta_test, :notice => 'Beta test was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /beta_tests/1
  def update
    @beta_test = BetaTest.find(params[:id])

    respond_to do |format|
      if @beta_test.update_attributes(params[:beta_test])
        redirect_to(@beta_test, :notice => 'Beta test was successfully updated.')
      else
        render :action => "edit"
      end
    end
  end

  # DELETE /beta_tests/1
  def destroy
    @beta_test = BetaTest.find(params[:id])
    @beta_test.destroy
    redirect_to(beta_tests_url)
  end

  def load_beta_test
    @beta_test = BetaTest.find params[:id]
  end
end
