class ForumCategoriesController < ApplicationController

  access_control do
    allow :tester, :of => :current_beta_test, :to => [:index]
    deny :deactivated, :waiting, :for => :current_beta_test
    allow :developer, :of => :current_beta_test, :except => [:show]
    allow :admin
  end

  # GET /forum_categories
  # GET /forum_categories.xml
  def index
    @forum_categories = current_beta_test.forum_categories
  end

  # GET /forum_categories/1
  # GET /forum_categories/1.xml
  def show
    redirect_to beta_test_forum_category_forum_topics_path(current_beta_test, current_forum_category, :notice => 'Forum category was successfully created.')
  end

  # GET /forum_categories/new
  # GET /forum_categories/new.xml
  def new
    @forum_category = ForumCategory.new
  end

  # GET /forum_categories/1/edit
  def edit
    @forum_category = ForumCategory.find(params[:id])
  end

  # POST /forum_categories
  # POST /forum_categories.xml
  def create
    @forum_category = ForumCategory.new(params[:forum_category])
    @forum_category.beta_test = current_beta_test

    if @forum_category.save
      redirect_to beta_test_forum_categories_path(current_beta_test, :notice => 'Forum category was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /forum_categories/1
  # PUT /forum_categories/1.xml
  def update
    @forum_category = ForumCategory.find(params[:id])

    if @forum_category.update_attributes(params[:forum_category])
      redirect_to beta_test_forum_categories_path(current_beta_test, :notice => 'Forum category was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /forum_categories/1
  # DELETE /forum_categories/1.xml
  def destroy
    @forum_category = ForumCategory.find(params[:id])
    @forum_category.destroy

    redirect_to(forum_categories_url)
  end
end
