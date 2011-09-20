class SurveysController < ApplicationController
  access_control do
    allow :tester, :of => :current_beta_test, :to => [:index]
    deny :deactivated, :waiting, :for => :current_beta_test
    allow :developer, :of => :current_beta_test
    allow :admin
  end

  def index
    @surveys = Survey.where(:beta_test_id => current_beta_test.id)
  end

  def show
    @survey = Survey.find(params[:id])
    @survey_options = SurveyOption.where(:survey_id => @survey.id)
  end

  def new
    @survey = Survey.new
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def create
    @survey = Survey.new(params[:survey])

    if @survey.save
      redirect_to(@survey, :notice => 'Survey was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @survey = Survey.find(params[:id])

    if @survey.update_attributes(params[:survey])
      redirect_to(@survey, :notice => 'Survey was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
  end
end
