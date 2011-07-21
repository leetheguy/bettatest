class ForumPostsController < ApplicationController
  before_filter :current_beta_test, :current_forum_category, :current_forum_topic
  before_filter :involved_only, :active_only

  access_control do
    deny :deactivated, :waiting, :for => :current_beta_test
    allow :involved, :in => :current_beta_test, :to => [:index], :if => :involved_only
    allow :involved, :active, :in => :current_beta_test, :to => [:index], :if => :active_only
    allow :activated, :in => :current_beta_test, :to => [:index], :if => :activated_only
    allow :developer, :of => :current_beta_test, :except => [:show]
    allow :admin
  end

  def rate_up
    ForumPost.find(params[:id]).rate_up!
    if !current_user.has_role?(:admin) && !current_user.has_role(:developer, :current_beta_test)
      TesterStatSheet.where(:user_id => current_user).where(:beta_test_id => current_beta_test).first.forum_rate_up!(params[:id])
    end
    @forum_posts = current_forum_topic.forum_posts
    render :index
  end

  def rate_down
    ForumPost.find(params[:id]).rate_down!
    if !current_user.has_role?(:admin) && !current_user.has_role(:developer, :current_beta_test)
      TesterStatSheet.where(:user_id => current_user).where(:beta_test_id => current_beta_test).first.forum_rate_down!(params[:id])
    end
    @forum_posts = current_forum_topic.forum_posts
    render :index
  end

  # GET /forum_posts
  # GET /forum_posts.xml
  def index
    @forum_posts = current_forum_topic.forum_posts
  end

  # GET /forum_posts/1
  # GET /forum_posts/1.xml
  def show
    redirect_to beta_test_forum_category_forum_topic_forum_posts_path(current_beta_test, current_forum_category, current_forum_topic)
  end

  # GET /forum_posts/new
  # GET /forum_posts/new.xml
  def new
    @forum_post = ForumPost.new
  end

  # GET /forum_posts/1/edit
  def edit
    @forum_post = ForumPost.find(params[:id])
  end

  # POST /forum_posts
  # POST /forum_posts.xml
  def create
    @forum_post = ForumPost.new(params[:forum_post])
    @forum_post.forum_topic = current_forum_topic
    @forum_post.user = current_user

    if @forum_post.save
      redirect_to beta_test_forum_category_forum_topic_forum_posts_path(current_beta_test, current_forum_category, current_forum_topic, :notice => 'Forum post was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /forum_posts/1
  # PUT /forum_posts/1.xml
  def update
    @forum_post = ForumPost.find(params[:id])

    if @forum_post.update_attributes(params[:forum_post])
      redirect_to beta_test_forum_category_forum_topic_forum_posts_path(current_beta_test, current_forum_category, current_forum_topic, :notice => 'Forum post was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /forum_posts/1
  # DELETE /forum_posts/1.xml
  def destroy
    @forum_post = ForumPost.find(params[:id])
    @forum_post.destroy

    redirect_to beta_test_forum_category_forum_topic_forum_posts_path(current_beta_test, current_forum_category, current_forum_topic)
  end
end
