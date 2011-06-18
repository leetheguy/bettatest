class SurveyOptionsController < ApplicationController
  before_filter :current_beta_test, :current_survey
  before_filter :involved_only, :active_only

  access_control do
    deny :deactivated, :waiting, :for => :current_beta_test
    allow :involved, :in => :current_beta_test, :to => [:index, :update], :if => :involved_only
    allow :involved, :active, :in => :current_beta_test, :to => [:index, :update], :if => :active_only
    allow :activated, :in => :current_beta_test, :to => [:index, :update], :if => :activated_only
    allow :developer, :of => :current_beta_test, :except => [:show]
    allow :admin
  end

  # GET /survey_options
  # GET /survey_options.xml
  def index
    @survey_options = SurveyOption.where(:survey => current_survey)
  end

  # GET /survey_options/1
  # GET /survey_options/1.xml
  def show
    @survey_option = SurveyOption.find(params[:id])
  end

  # GET /survey_options/new
  # GET /survey_options/new.xml
  def new
    @survey_option = SurveyOption.new
  end

  # GET /survey_options/1/edit
  def edit
    @survey_option = SurveyOption.find(params[:id])
  end

  # POST /survey_options
  # POST /survey_options.xml
  def create
    @survey_option = SurveyOption.new(params[:survey_option])

    if @survey_option.save
      redirect_to(@survey_option, :notice => 'Survey option was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /survey_options/1
  # PUT /survey_options/1.xml
  def update
    @survey_option = SurveyOption.find(params[:id])

    if @survey_option.update_attributes(params[:survey_option])
      redirect_to(@survey_option, :notice => 'Survey option was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /survey_options/1
  # DELETE /survey_options/1.xml
  def destroy
    @survey_option = SurveyOption.find(params[:id])
    @survey_option.destroy

    redirect_to(survey_options_url)
  end
end
