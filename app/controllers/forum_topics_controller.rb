class ForumTopicsController < ApplicationController
  access_control do
    deny :deactivated, :waiting, :for => :current_beta_test
    allow :involved, :in => :current_beta_test, :to => [:index], :if => :involved_only
    allow :involved, :active, :in => :current_beta_test, :to => [:index], :if => :active_only
    allow :activated, :in => :current_beta_test, :to => [:index], :if => :activated_only
    allow :developer, :of => :current_beta_test, :except => [:show]
    allow :admin
  end

  # GET /forum_topics
  # GET /forum_topics.xml
  def index
    @forum_topics = ForumTopic.where(:forum_category_id => params[:forum_category_id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /forum_topics/1
  # GET /forum_topics/1.xml
  def show
    @forum_topic = ForumTopic.find(params[:id])
    @forum_posts = ForumPost.where(:forum_topic_id => @forum_topic.id).page(params[:page]).per(10)
  end

  # GET /forum_topics/new
  # GET /forum_topics/new.xml
  def new
    @forum_topic = ForumTopic.new
    @forum_topic.forum_category_id = params[:forum_category_id]
  end

  # GET /forum_topics/1/edit
  def edit
    @forum_topic = ForumTopic.find(params[:id])
  end

  # POST /forum_topics
  # POST /forum_topics.xml
  def create
    @forum_topic = ForumTopic.new(params[:forum_topic])
    @forum_topic.user = current_user

    if @forum_topic.save
      redirect_to @forum_topic, :notice => 'Forum topic was successfully created.'
    else
      render :action => "new"
    end
  end

  # PUT /forum_topics/1
  # PUT /forum_topics/1.xml
  def update
    @forum_topic = ForumTopic.find(params[:id])

    if @forum_topic.update_attributes(params[:forum_topic])
      redirect_to @forum_topic, :notice => 'Forum topic was successfully updated.'
    else
      render :action => "edit"
    end
  end

  # DELETE /forum_topics/1
  # DELETE /forum_topics/1.xml
  def destroy
    @forum_topic = ForumTopic.find(params[:id])
    @forum_category = @forum_topic.forum_category
    @forum_topic.destroy

    redirect_to @forum_category
  end
end
