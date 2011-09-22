class SurveysController < ApplicationController
  access_control do
    allow :tester, :of => :current_beta_test, :to => [:index]
    deny :deactivated, :waiting, :for => :current_beta_test
    allow :developer, :of => :current_beta_test
    allow :admin
  end

  def index
    @surveys = Survey.surveys_for(current_user, current_beta_test)
  end

  def show
    @surveys = Survey.surveys_for(current_user, current_beta_test)
    @survey = Survey.find(params[:id])
    @survey_options = @survey.survey_options
    respond_to do |format|
      format.html do
        redirect_to survey_path
      end
      format.js
    end
  end

  def new
    @survey = Survey.new
  end

  def edit
    @survey = Survey.find(params[:id])
  end

  def create
    @surveys = Survey.surveys_for(current_user, current_beta_test)
    @survey = Survey.new(params[:survey])
    @survey.beta_test = current_beta_test

    if params[:commit] == "cancel"
      redirect_to surveys_path
    elsif @survey.save
      redirect_to surveys_path, :notice => 'Survey was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    @survey = Survey.find(params[:id])

    if @survey.update_attributes(params[:survey])
      redirect_to @survey, :notice => 'Survey was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @surveys = Survey.surveys_for(current_user, current_beta_test)
    survey = Survey.find(params[:id])
    survey.destroy
    redirect_to surveys_path

  end
end
