class TesterStatSheetsController < ApplicationController
  access_control do
    allow :tester, :developer, :of => :beta_test, :to => [:index]
    allow :user, :to => [:create]
    deny  :tester, :developer, :of => :beta_test, :to => [:create]
    allow :admin
  end

  # GET /tester_stat_sheets
  # GET /tester_stat_sheets.xml
  def index
    if current_beta_test.open
      redirect_to current_beta_test
    else
      @tester_stat_sheets = current_beta_test.ordered_stat_sheets
    end
  end

  # GET /tester_stat_sheets/1
  # GET /tester_stat_sheets/1.xml
  def show
    @tester_stat_sheet = TesterStatSheet.find(params[:id])
  end

  # GET /tester_stat_sheets/new
  # GET /tester_stat_sheets/new.xml
  def new
    @tester_stat_sheet = TesterStatSheet.new
  end

  # GET /tester_stat_sheets/1/edit
  def edit
    @tester_stat_sheet = TesterStatSheet.find(params[:id])
  end

  # POST /tester_stat_sheets
  # POST /tester_stat_sheets.xml
  def create
    if params[:beta_test_id]
      beta_test = BetaTest.find(params[:beta_test_id])
    elsif current_beta_test
      beta_test = current_beta_test
    else
      redirect_to beta_tests_path
    end

    if beta_test.active && !beta_test.open
      @tester_stat_sheet = TesterStatSheet.new
      @tester_stat_sheet.user = current_user
      @tester_stat_sheet.beta_test = beta_test
      if @tester_stat_sheet.save
        notice = 'You have successfully signed up for this betta test.'
        if @tester_stat_sheet.waiting?
          notice += "#{beta_test.name} is full. You will be notified when you are allowed to participate."
        end
        flash[:notice] = notice
      end
    end
    redirect_to beta_test
  end

  # PUT /tester_stat_sheets/1
  # PUT /tester_stat_sheets/1.xml
  def update
    @tester_stat_sheet = TesterStatSheet.find(params[:id])

    if @tester_stat_sheet.update_attributes(params[:tester_stat_sheet])
      redirect_to(@tester_stat_sheet, :notice => 'Tester stat sheet was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /tester_stat_sheets/1
  # DELETE /tester_stat_sheets/1.xml
  def destroy
    @tester_stat_sheet = TesterStatSheet.find(params[:id])
    @tester_stat_sheet.destroy

    redirect_to(tester_stat_sheets_url)
  end
end
