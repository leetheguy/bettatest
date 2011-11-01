class BetaTestsController < ApplicationController
  load_and_authorize_resource

  # GET /beta_tests
  def index
    @title = 'list of betta tests'

    @beta_tests = @beta_tests.order(:name).page(params[:page]).per(20)
  end

  # GET /beta_tests/1
  def show
    @blogs = Blog.accessible_by(current_ability).order('created_at DESC')[0..2]
    @forum_categories = ForumCategory.accessible_by(current_ability)
    if can? :read, TesterStatSheet
      @tester_stat_sheets = current_beta_test.ordered_stat_sheets[0..10]
    end
  end

  # GET /beta_tests/new
  def new
  end

  # GET /beta_tests/1/edit
  def edit
  end

  # POST /beta_tests
  def create
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
    if params[:commit] == "cancel"
      redirect_to beta_test_path(@beta_test)

    elsif params[:commit] == "make public"
      @beta_test.open_test
      @beta_test.save!
      flash[:notice] = 'Your betta test is now accessible to the general public.'
      redirect_to(@beta_test)

    elsif params[:commit] == "activate"
      if @beta_test.activate_test!
        flash[:notice] = 'Your betta test is now ready for testing.'
        redirect_to(@beta_test)
      else
        render :action => "edit"
      end

    elsif params[:commit] == "deactivate"
      @beta_test.deactivate_test!
      flash[:notice] = 'Your betta test is now closed to new testers.'
      redirect_to(@beta_test)

    elsif @beta_test.update_attributes(params[:beta_test])
      redirect_to(@beta_test, :notice => 'Betta test was successfully updated.')

    else
      render :action => "edit"

    end
  end

  # DELETE /beta_tests/1
  def destroy
    @beta_test.destroy
    redirect_to beta_tests_path
  end
end
