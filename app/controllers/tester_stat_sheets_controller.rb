class TesterStatSheetsController < ApplicationController
  # GET /tester_stat_sheets
  # GET /tester_stat_sheets.xml
  def index
    @tester_stat_sheets = TesterStatSheet.all
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
    @tester_stat_sheet = TesterStatSheet.new(params[:tester_stat_sheet])

    if @tester_stat_sheet.save
      redirect_to(@tester_stat_sheet, :notice => 'Tester stat sheet was successfully created.')
    else
      render :action => "new"
    end
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
