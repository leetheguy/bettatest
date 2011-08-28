class ForumTopicsController < ApplicationController
  before_filter :current_beta_test, :current_forum_category
  before_filter :involved_only, :active_only

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
    @forum_topics = current_forum_category.forum_topics #ForumTopic.where(:forum_category_id => :current_forum_category)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /forum_topics/1
  # GET /forum_topics/1.xml
  def show
    redirect_to beta_test_forum_category_forum_topic_forum_posts_path(current_beta_test, current_forum_category, current_forum_topic)
  end

  # GET /forum_topics/new
  # GET /forum_topics/new.xml
  def new
    @forum_topic = ForumTopic.new
  end

  # GET /forum_topics/1/edit
  def edit
    @forum_topic = ForumTopic.find(params[:id])
  end

  # POST /forum_topics
  # POST /forum_topics.xml
  def create
    @forum_topic = ForumTopic.new(params[:forum_topic])
    @forum_topic.forum_category = current_forum_category
    @forum_topic.user = current_user

    if @forum_topic.save
      puts current_beta_test
      puts current_forum_category
      redirect_to beta_test_forum_category_forum_topics_path(current_beta_test, current_forum_category, :notice => 'Forum topic was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /forum_topics/1
  # PUT /forum_topics/1.xml
  def update
    @forum_topic = ForumTopic.find(params[:id])

    if @forum_topic.update_attributes(params[:forum_topic])
      redirect_to beta_test_forum_category_forum_topics_path(current_beta_test, current_forum_category, :notice => 'Forum topic was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /forum_topics/1
  # DELETE /forum_topics/1.xml
  def destroy
    @forum_topic = ForumTopic.find(params[:id])
    @forum_topic.destroy

      redirect_to beta_test_forum_category_forum_topics_path(current_beta_test, current_forum_category)
  end
end
