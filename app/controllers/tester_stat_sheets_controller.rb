class TesterStatSheetsController < ApplicationController
  load_and_authorize_resource :only => :show

  # GET /tester_stat_sheets
  # GET /tester_stat_sheets.xml
  def index
    authorize! :index, TesterStatSheet
    @tester_stat_sheets = current_beta_test.ordered_stat_sheets
  end

  # GET /tester_stat_sheets/1
  # GET /tester_stat_sheets/1.xml
  def show
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
    @tester_stat_sheet = TesterStatSheet.new
    current_ability.attributes_for(:create, TesterStatSheet).each do |key, value|
      @tester_stat_sheet.send("#{key}=", value)
    end
    authorize! :create, @tester_stat_sheet

    if @tester_stat_sheet.save
      notice = 'You have successfully signed up for this betta test.'
      if @tester_stat_sheet.waiting?
        notice += " However, #{current_beta_test.name} is full. You will be notified when you are allowed to participate."
      end
      flash[:notice] = notice
    end
    redirect_to current_beta_test
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
