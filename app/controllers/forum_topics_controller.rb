class ForumTopicsController < ApplicationController
  access_control do
    deny :deactivated, :waiting, :for => :current_beta_test
    allow :tester, :of => :current_beta_test, :to => [:index, :show, :new, :create]
    allow :developer, :of => :current_beta_test
    allow :user, :to => [:index, :show, :new, :create], :if => :current_beta_test_is_open
    allow :admin
  end

  # GET /forum_topics
  # GET /forum_topics.xml
  def index
    @forum_category = ForumCategory.find(params[:forum_category_id])
    if @forum_category.is_visible_to(current_user)
      @forum_topics = @forum_category.forum_topics.page(params[:page]).per(20)
    else
      redirect_to forum_categories_path
    end
  end

  # GET /forum_topics/1
  # GET /forum_topics/1.xml
  def show
    @forum_topic = ForumTopic.find(params[:id])
    if @forum_topic.forum_category.is_visible_to(current_user)
      redirect_to forum_posts_path(:forum_topic_id => @forum_topic)
    else
      redirect_to forum_categories
    end
#    @forum_category = @forum_topic.forum_category
#    @forum_topics = @forum_category.forum_topics
#    @forum_topic = ForumTopic.find(params[:id])
#    if @forum_category.is_visible_to(current_user)
#      respond_to do |format|
#        format.html do
#          redirect_to forum_posts_path(:forum_topic_id => @forum_topic)
#        end
#        format.js do
#          @forum_posts = ForumPost.where(:forum_topic_id => @forum_topic).order("created_at DESC").limit(5)
#        end
#      end
#    else
#      redirect_to forum_topics_path(:forum_category_id => @forum_category.id)
#    end
  end

  # GET /forum_topics/new
  # GET /forum_topics/new.xml
  def new
    @forum_category = ForumCategory.find(params[:forum_category_id])
    @forum_topic = ForumTopic.new
    @forum_topic.forum_category = @forum_category
  end

  # GET /forum_topics/1/edit
  def edit
    @forum_topic = ForumTopic.find(params[:id])
  end

  # POST /forum_topics
  # POST /forum_topics.xml
  def create
    #@forum_category = ForumCategory.find(params[:forum_category_id])
    @forum_topic = ForumTopic.new(params[:forum_topic])
    @forum_topic.user = current_user
    @forum_topic.forum_category_id = params[:forum_topic][:forum_category_id]

    if params[:commit] == 'cancel'
      redirect_to forum_topics_path(:forum_category_id => @forum_topic.forum_category)
    elsif @forum_topic.save
      redirect_to @forum_topic, :notice => 'Topic was successfully created.'
    else
      render :action => 'new'
    end
  end

  # PUT /forum_topics/1
  # PUT /forum_topics/1.xml
  def update
    @forum_topic = ForumTopic.find(params[:id])

    if params[:commit] == 'cancel'
      redirect_to forum_topics_path(:forum_category_id => @forum_topic.forum_category.id)
    elsif @forum_topic.update_attributes(params[:forum_topic])
      redirect_to forum_topics_path(:forum_category_id => @forum_topic.forum_category.id), :notice => 'Topic was successfully updated.'
    else
      render :action => "edit"
    end
  end

  # DELETE /forum_topics/1
  # DELETE /forum_topics/1.xml
  def destroy
    @forum_category = ForumCategory.find(params[:forum_category_id])
    @forum_topic = ForumTopic.find(params[:id])
    @forum_topic.destroy

    redirect_to @forum_category
   end
end
