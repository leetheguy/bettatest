class SurveyOptionsController < ApplicationController
  # GET /survey_options
  # GET /survey_options.xml
  def index
    @survey_options = SurveyOption.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @survey_options }
    end
  end

  # GET /survey_options/1
  # GET /survey_options/1.xml
  def show
    @survey_option = SurveyOption.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @survey_option }
    end
  end

  # GET /survey_options/new
  # GET /survey_options/new.xml
  def new
    @survey_option = SurveyOption.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @survey_option }
    end
  end

  # GET /survey_options/1/edit
  def edit
    @survey_option = SurveyOption.find(params[:id])
  end

  # POST /survey_options
  # POST /survey_options.xml
  def create
    @survey_option = SurveyOption.new(params[:survey_option])

    respond_to do |format|
      if @survey_option.save
        format.html { redirect_to(@survey_option, :notice => 'Survey option was successfully created.') }
        format.xml  { render :xml => @survey_option, :status => :created, :location => @survey_option }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @survey_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /survey_options/1
  # PUT /survey_options/1.xml
  def update
    @survey_option = SurveyOption.find(params[:id])

    respond_to do |format|
      if @survey_option.update_attributes(params[:survey_option])
        format.html { redirect_to(@survey_option, :notice => 'Survey option was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @survey_option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_options/1
  # DELETE /survey_options/1.xml
  def destroy
    @survey_option = SurveyOption.find(params[:id])
    @survey_option.destroy

    respond_to do |format|
      format.html { redirect_to(survey_options_url) }
      format.xml  { head :ok }
    end
  end
end
