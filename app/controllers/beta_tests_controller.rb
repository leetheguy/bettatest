class BetaTestsController < ApplicationController
  access_control do
    allow all, :to => [:index, :show]
    allow :user, :tester, :to => [:new, :create]
    allow :developer, :of => :current_beta_test, :to => [:edit, :update]
    deny :developer, :to => [:new, :create]
    allow :admin
  end

  # GET /beta_tests
  def index
    @beta_tests = BetaTest.where(:active => true).order(:name).page(params[:page]).per(20)
  end

  # GET /beta_tests/1
  def show
    @beta_test = current_beta_test
    if @beta_test.active || current_user.has_role?(:admin) || current_user.has_role?(:developer)
      @blogs = current_beta_test.blogs.where(:draft => false).order('created_at DESC')[0..2]
      @forum_categories = current_beta_test.categories_for(current_user)
      if current_user && current_user.has_role?(:tester, current_beta_test)
        @tester_stat_sheets = current_beta_test.ordered_stat_sheets[0...10]
      else
        @tester_stat_sheets = []
      end
    else
      redirect_to beta_tests_path
    end
  end

  # GET /beta_tests/new
  def new
    @beta_test = BetaTest.new
    binding.pry
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
      flash[:notice] = 'Your betta test is now accessible to the general public.'
      render :action => 'edit'

    elsif params[:commit] == "activate"
      @beta_test.activate_test
      @beta_test.save!
      flash[:notice] = 'Your betta test is now ready for testing.'
      render :action => 'edit'

    elsif params[:commit] == "deactivate"
      @beta_test.deactivate_test
      @beta_test.save!
      flash[:notice] = 'Your betta test is now closed to new testers.'
      render :action => 'edit'

    elsif @beta_test.update_attributes(params[:beta_test])
      redirect_to(@beta_test, :notice => 'Betta test was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /beta_tests/1
  def destroy
    current_beta_test.destroy
    redirect_to beta_tests_path
  end
end
