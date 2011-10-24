class ForumPostsController < ApplicationController
  load_and_authorize_resource :forum_topic, :only => [:index, :show, :new]
  load_and_authorize_resource :through => :forum_topic, :only => [:index, :show, :new]
  load_and_authorize_resource :forum_post, :except => [:index, :show, :new, :create]

  def rate_up
    if @forum_post.user != current_user
      @forum_topic = @forum_post.forum_topic
      @forum_posts = @forum_topic.forum_posts.page(params[:page]).per(20)
      flash[:notice] = 'Thanks for rating!'
      current_beta_test.stat_sheet_for(current_user).forum_rate_up!(@forum_post)
    end
    redirect_to forum_posts_path(:forum_topic_id => @forum_topic)
  end

  def rate_down
    if @forum_post.user != current_user
      @forum_topic = @forum_post.forum_topic
      @forum_posts = @forum_topic.forum_posts.page(params[:page]).per(20)
      flash[:notice] = 'Thanks for rating!'
      current_beta_test.stat_sheet_for(current_user).forum_rate_down!(@forum_post)
    end
    redirect_to forum_posts_path(:forum_topic_id => @forum_topic)
  end

  # GET /forum_posts
  # GET /forum_posts.xml
  def index
    authorize! :read, @forum_topic.forum_category
    @forum_posts = @forum_posts.page(params[:page]).per(20)
  end

  # GET /forum_posts/1
  # GET /forum_posts/1.xml
  def show
    authorize! :read, @forum_topic.forum_category
    redirect_to forum_posts_path(:forum_topic_id => @forum_topic)
  end

  # GET /forum_posts/new
  # GET /forum_posts/new.xml
  def new
    authorize! :read, @forum_topic.forum_category
  end

  # GET /forum_posts/1/edit
  def edit
  end

  # POST /forum_posts
  # POST /forum_posts.xml
  def create
    @forum_topic = ForumTopic.find(params[:forum_post][:forum_topic_id])
    authorize! :read, @forum_topic.forum_category
    @forum_category = @forum_topic.forum_category
    @forum_post = ForumPost.new
    @forum_post.attributes = params[:forum_post]
    @forum_post.forum_topic = @forum_topic
    @forum_post.user = current_user
    authorize! :read, @forum_category

    if params[:commit] == 'cancel'
      redirect_to forum_posts_path(:forum_topic_id => @forum_topic)
    elsif @forum_post.save
      redirect_to forum_posts_path(:forum_topic_id => @forum_topic), :notice => 'Topic was successfully created.'
    else
      render :action => 'new'
    end
  end

  # PUT /forum_posts/1
  # PUT /forum_posts/1.xml
  def update
    if params[:commit] == 'cancel'
      redirect_to forum_posts_path(:forum_topic_id => @forum_post.forum_topic)
    elsif @forum_post.update_attributes(params[:forum_post])
      redirect_to forum_posts_path(:forum_topic_id => @forum_post.forum_topic), :notice => 'Post was successfully updated.'
    else
      render :action => "edit"
    end
  end

  # DELETE /forum_posts/1
  # DELETE /forum_posts/1.xml
  def destroy
    @forum_topic = @forum_post.forum_topic
    @forum_post.destroy

    redirect_to forum_posts_path(:forum_topic_id => @forum_topic), :notice => 'Post was successfully destroyed.'
  end
end
