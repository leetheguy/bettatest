class ForumCategoriesController < ApplicationController
  access_control do
    allow :tester, :of => :current_beta_test, :to => [:index]
    deny :deactivated, :waiting, :for => :current_beta_test
    allow :developer, :of => :current_beta_test, :except => [:show]
    allow :admin
  end

  def index
    @forum_categories = ForumCategory.categories_for(current_user, current_beta_test)
  end

  def show
    @forum_categories = ForumCategory.where(:beta_test_id => current_beta_test.id)
    @forum_category = ForumCategory.find(params[:id])
    @forum_topics = @forum_category.forum_topics
    respond_to do |format|
      format.html do
        redirect_to forum_categories_path
      end
      format.js
    end
  end

  def new
    @forum_category = ForumCategory.new
  end

  def edit
    @forum_category = ForumCategory.find(params[:id])
  end

  def create
    @forum_categories = ForumCategory.where(:beta_test_id => current_beta_test.id)
    @forum_category = ForumCategory.new(params[:forum_category])
    @forum_category.beta_test = current_beta_test
    if params[:commit] == "cancel"
      redirect_to forum_categories_path
    elsif @forum_category.save
      redirect_to forum_categories_path, :notice => 'Forum category was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    @forum_categories = ForumCategory.where(:beta_test_id => current_beta_test.id)
    @forum_category = ForumCategory.find(params[:id])

    if @forum_category.update_attributes(params[:forum_category])
      redirect_to forum_categories_path, :notice => 'Forum category was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @forum_categories = ForumCategory.where(:beta_test_id => current_beta_test.id)
    @forum_category = ForumCategory.find(params[:id])
    @forum_category.destroy
    redirect_to forum_categories_path
  end
end
