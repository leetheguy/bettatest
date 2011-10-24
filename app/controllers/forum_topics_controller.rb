class ForumTopicsController < ApplicationController
  load_and_authorize_resource :forum_category, :only => [:index, :show, :new]
  load_and_authorize_resource :through => :forum_category, :only => [:index, :show, :new]
  load_and_authorize_resource :forum_topic, :except => [:index, :show, :new, :create]

  # GET /forum_topics
  # GET /forum_topics.xml
  def index
    authorize! :read, @forum_category
    @forum_topics = @forum_topics.page(params[:page]).per(20)
  end

  # GET /forum_topics/1
  # GET /forum_topics/1.xml
  def show
    authorize! :read, @forum_categorjy
    redirect_to forum_posts_path(:forum_topic_id => @forum_topic)
  end

  # GET /forum_topics/new
  # GET /forum_topics/new.xml
  def new
    authorize! :read, @forum_category
  end

  # GET /forum_topics/1/edit
  def edit
  end

  # POST /forum_topics
  # POST /forum_topics.xml
  def create
    @forum_category = ForumCategory.find(params[:forum_topic][:forum_category_id])
    authorize! :read, @forum_category
    @forum_topic = ForumTopic.new
    @forum_topic.attributes = params[:forum_topic]
    @forum_topic.forum_category = @forum_category
    @forum_topic.user = current_user
    authorize! :read, @forum_category

    if params[:commit] == 'cancel'
      redirect_to forum_topics_path(:forum_category_id => @forum_category)
    elsif @forum_topic.save
      redirect_to forum_posts_path(:forum_topic_id => @forum_topic), :notice => 'Topic was successfully created.'
    else
      render :action => 'new'
    end
  end

  # PUT /forum_topics/1
  # PUT /forum_topics/1.xml
  def update
    if params[:commit] == 'cancel'
      redirect_to forum_topics_path(:forum_category_id => @forum_topic.forum_category)
    elsif @forum_topic.update_attributes(params[:forum_topic])
      redirect_to forum_topics_path(:forum_category_id => @forum_topic.forum_category), :notice => 'Topic was successfully updated.'
    else
      render :action => "edit"
    end
  end

  # DELETE /forum_topics/1
  # DELETE /forum_topics/1.xml
  def destroy
    @forum_category = @forum_topic.forum_category
    @forum_topic.destroy

    redirect_to forum_topics_path(:forum_category_id => @forum_category)
   end
end
