class SurveysController < ApplicationController
  before_filter :current_beta_test

  access_control do
    deny :deactivated, :waiting, :for => :current_beta_test
    allow :tester, :of => :current_beta_test, :to => [:index]
    allow :developer, :of => :current_beta_test, :except => [:show]
    allow :admin
  end

  # GET /surveys
  # GET /surveys.xml
  def index
    @surveys = Survey.where(:beta_test => current_beta_test)
  end

  # GET /surveys/1
  # GET /surveys/1.xml
  def show
    @survey = Survey.find(params[:id])
  end

  # GET /surveys/new
  # GET /surveys/new.xml
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
    @survey = Survey.find(params[:id])
  end

  # POST /surveys
  # POST /surveys.xml
  def create
    @survey = Survey.new(params[:survey])

    if @survey.save
      redirect_to(@survey, :notice => 'Survey was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /surveys/1
  # PUT /surveys/1.xml
  def update
    @survey = Survey.find(params[:id])

    if @survey.update_attributes(params[:survey])
      redirect_to(@survey, :notice => 'Survey was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.xml
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy

    redirect_to(surveys_url)
  end
end
