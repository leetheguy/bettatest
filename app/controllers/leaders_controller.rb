class LeadersController < ApplicationController
  # GET /leaders
  # GET /leaders.xml
  def index
    #@leader_stat_sheets = TesterStatSheet.where(:beta_test_id => current_beta_test)
  end

  # GET /leaders/1
  # GET /leaders/1.xml
  def show
    @leader = Leader.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @leader }
    end
  end

  # GET /leaders/new
  # GET /leaders/new.xml
  def new
    @leader = Leader.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @leader }
    end
  end

  # GET /leaders/1/edit
  def edit
    @leader = Leader.find(params[:id])
  end

  # POST /leaders
  # POST /leaders.xml
  def create
    @leader = Leader.new(params[:leader])

    respond_to do |format|
      if @leader.save
        format.html { redirect_to(@leader, :notice => 'Leader was successfully created.') }
        format.xml  { render :xml => @leader, :status => :created, :location => @leader }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @leader.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /leaders/1
  # PUT /leaders/1.xml
  def update
    @leader = Leader.find(params[:id])

    respond_to do |format|
      if @leader.update_attributes(params[:leader])
        format.html { redirect_to(@leader, :notice => 'Leader was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @leader.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /leaders/1
  # DELETE /leaders/1.xml
  def destroy
    @leader = Leader.find(params[:id])
    @leader.destroy

    respond_to do |format|
      format.html { redirect_to(leaders_url) }
      format.xml  { head :ok }
    end
  end
end
