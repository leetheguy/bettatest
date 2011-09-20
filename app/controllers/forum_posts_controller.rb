class ForumPostsController < ApplicationController
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
    @forum_posts = ForumPost.where(:forum_topic_id => params[:forum_topic_id])
  end

  # GET /forum_posts/1
  # GET /forum_posts/1.xml
  def show
    @forum_post = ForumPost.find(params[:id])
    redirect_to @forum_post
  end

  # GET /forum_posts/new
  # GET /forum_posts/new.xml
  def new
    @forum_post = ForumPost.new
    @forum_post.forum_topic_id = params[:forum_topic_id]
  end

  # GET /forum_posts/1/edit
  def edit
    @forum_post = ForumPost.find(params[:id])
  end

  # POST /forum_posts
  # POST /forum_posts.xml
  def create
    @forum_post = ForumPost.new(params[:forum_post])
    @forum_post.forum_topic_id = params[:forum_post][:forum_topic_id]
    @forum_post.user = current_user

    if params[:commit] == "cancel"
      redirect_to forum_topic_path(@forum_post.forum_topic_id)
    elsif @forum_post.save
      redirect_to forum_topic_path(@forum_post.forum_topic_id, :notice => 'Post was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /forum_posts/1
  # PUT /forum_posts/1.xml
  def update
    @forum_post = ForumPost.find(params[:id])

    if params[:commit] == "cancel"
      redirect_to forum_topic_path(@forum_post.forum_topic_id)
    elsif @forum_post.update_attributes(params[:forum_post])
      redirect_to forum_topic_path(@forum_post.forum_topic_id, :notice => 'Post was successfully created.')
    else
      render :action => "edit"
    end
  end

  # DELETE /forum_posts/1
  # DELETE /forum_posts/1.xml
  def destroy
    @forum_post = ForumPost.find(params[:id])
    @forum_topic = @forum_post.forum_topic
    @forum_post.destroy

    redirect_to @forum_topic
  end
end
