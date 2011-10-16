class ForumPostsController < ApplicationController
  access_control do
    deny :deactivated, :waiting, :for => :current_beta_test
    allow :tester, :of => :current_beta_test, :to => [:index, :show, :new, :create, :rate_up, :rate_down]
    allow :developer, :of => :current_beta_test
    allow :owner, :of => :forum_post, :to => [:edit, :update]
    allow :user, :to => [:index, :show, :new, :create], :if => :current_beta_test_is_open
    allow :admin
  end

  def rate_up
    @forum_post = ForumPost.find params[:id]
    @forum_topic = @forum_post.forum_topic
    @forum_posts = @forum_topic.forum_posts.page(params[:page]).per(20)
    if !current_user.has_role?(:admin) && !current_user.has_role?(:developer, current_beta_test) && !current_user.has_role?(:owner, @forum_post)
      flash[:notice] = 'Thanks for rating!'
      current_beta_test.stat_sheet_for(current_user).forum_rate_up!(@forum_post)
    end
    render :index
  end

  def rate_down
    @forum_post = ForumPost.find params[:id]
    @forum_topic = @forum_post.forum_topic
    @forum_posts = @forum_topic.forum_posts.page(params[:page]).per(20)
    if !current_user.has_role?(:admin) && !current_user.has_role?(:developer, current_beta_test) && !current_user.has_role?(:owner, @forum_post)
       flash[:notice] = 'Thanks for rating!'
      current_beta_test.stat_sheet_for(current_user).forum_rate_down!(@forum_post)
    end
    render :index
  end

  # GET /forum_posts
  # GET /forum_posts.xml
  def index
    @forum_topic = ForumTopic.find(params[:forum_topic_id])
    if @forum_topic.forum_category.is_visible_to(current_user)
      @forum_posts = @forum_topic.forum_posts.order('created_at DESC').page(params[:page]).per(20)
    else
      redirect_to forum_categories_path
    end
  end

  # GET /forum_posts/1
  # GET /forum_posts/1.xml
  def show
    @forum_post = ForumPost.find(params[:id])
    redirect_to forum_posts_path(:forum_topic_id => @forum_post.forum_topic)
  end

  # GET /forum_posts/new
  # GET /forum_posts/new.xml
  def new
    @forum_topic = ForumTopic.find params[:forum_topic_id]
    @forum_post = ForumPost.new
    @forum_post.forum_topic = @forum_topic
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

    if params[:commit] == 'cancel'
      redirect_to forum_posts_path(:forum_topic_id => @forum_post.forum_topic)
    elsif @forum_post.save
      redirect_to @forum_post.forum_topic, :notice => 'Post was successfully created.'
    else
      render :action => 'new'
    end
  end

  # PUT /forum_posts/1
  # PUT /forum_posts/1.xml
  def update
    @forum_post = forum_post

    if params[:commit] == 'cancel'
      redirect_to forum_posts_path(:forum_topic_id => @forum_post.forum_topic.id)
    elsif @forum_post.update_attributes(params[:forum_post])
      redirect_to forum_posts_path(:forum_topic_id => @forum_post.forum_topic.id), :notice => 'Post was successfully updated.'
    else
      render :action => "edit"
    end
  end

  # DELETE /forum_posts/1
  # DELETE /forum_posts/1.xml
  def destroy
    @forum_post = forum_post
    @forum_post.destroy
    redirect_to forum_posts_path(:forum_topic_id => @forum_post.forum_topic.id), :notice => 'Post was successfully destroyed.'
  end

  def forum_post
    post = nil
    if params[:id]
      post = ForumPost.find params[:id]
    end
    post
  end
end
