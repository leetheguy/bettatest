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

  # GET /forum_posts
  # GET /forum_posts.xml
  def index
    @forum_posts = ForumPost.where(:forum_topic => current_forum_topic)
  end

  # GET /forum_posts/1
  # GET /forum_posts/1.xml
  def show
    @forum_post = ForumPost.find(params[:id])
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

    if @forum_post.save
      redirect_to(@forum_post, :notice => 'Forum post was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /forum_posts/1
  # PUT /forum_posts/1.xml
  def update
    @forum_post = ForumPost.find(params[:id])

    if @forum_post.update_attributes(params[:forum_post])
      redirect_to(@forum_post, :notice => 'Forum post was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /forum_posts/1
  # DELETE /forum_posts/1.xml
  def destroy
    @forum_post = ForumPost.find(params[:id])
    @forum_post.destroy

    redirect_to(forum_posts_url)
  end
end
