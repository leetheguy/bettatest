class ForumCategoriesController < ApplicationController
  access_control do
    allow :tester, :of => :current_beta_test, :to => [:index, :show]
    deny :deactivated, :waiting, :for => :current_beta_test, :unless => :current_beta_test_is_open
    allow :developer, :of => :current_beta_test
    allow :user, :to => [:index, :show], :if => :current_beta_test_is_open
    allow :admin
  end

  def index
    @forum_categories = current_beta_test.categories_for(current_user).page(params[:page]).per(20)
  end

  def show
    @forum_categories = current_beta_test.categories_for(current_user)
    @forum_category = ForumCategory.find(params[:id])
    if @forum_category.is_visible_to(current_user)
      respond_to do |format|
        format.html do
          redirect_to forum_topics_path(:forum_category_id => @forum_category)
        end
        format.js do
          @forum_topics = ForumTopic.recently_changed(@forum_category)
        end
      end
    else
      redirect_to forum_categories_path
    end
  end

  def new
      @forum_category = ForumCategory.new
  end

  def edit
      @forum_category = ForumCategory.find(params[:id])
  end

  def create
    @forum_category = ForumCategory.new(params[:forum_category])
    @forum_category.beta_test = current_beta_test
    if params[:commit] == "cancel"
      redirect_to @forum_category
    elsif @forum_category.save
      redirect_to forum_categories_path, :notice => 'Forum category was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    @forum_category = ForumCategory.find(params[:id])

    if @forum_category.update_attributes(params[:forum_category])
      redirect_to @forum_category, :notice => 'Forum category was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @forum_categories = current_beta_test.categories_for(current_user)
    forum_category = ForumCategory.find(params[:id])
    forum_category.destroy
    redirect_to forum_categories_path
  end
end
