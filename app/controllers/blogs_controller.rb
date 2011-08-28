class BlogsController < ApplicationController
  skip_before_filter :clear_beta_test

  access_control do
    allow all, :to => [:index, :show, :feed]
    allow :developer, :of => :current_beta_test
    allow :admin
    allow :all
  end

  def feed
    @blogs = Blog.where(:beta_test_id => current_beta_test).where(:draft => false).order(:updated_at)
    @title = "the blog of the bettatest for #{current_beta_test.name}"
    # this will be our Feed's update timestamp
    @updated = @blogs.first.updated_at unless @blogs.empty?

    respond_to do |format|
      format.atom { render :layout => false }
      format.rss { redirect_to beta_test_feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

  def unpublished
    @published = false
    @blogs = Blog.where(:beta_test_id => current_beta_test).where(:draft => true).order(:created_at).page(params[:page]).per(10)
    render :action => :index
  end

  # GET /blogs
  def index
    @published = true
    @blogs = Blog.where(:beta_test_id => current_beta_test).where(:draft => false).order(:created_at).page(params[:page]).per(10)
  end

  # GET /blogs/1
  def show
    @blog = Blog.find(params[:id])
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(params[:id])
  end

  # POST /blogs
  def create
    @blog = Blog.new(params[:blog])
    @blog.beta_test = current_beta_test

    if params[:commit] == "save"
      @blog.draft = true
    elsif params[:commit] == "post"
      @blog.draft = false
      @blog.created_at = Time.now
    end

    if params[:commit] == "cancel"
      redirect_to beta_test_blogs_path(current_beta_test)
    elsif @blog.save
      redirect_to([current_beta_test, @blog], :notice => 'Blog was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /blogs/1
  def update
    @blog = Blog.find(params[:id])
    if params[:commit] == "save"
      @blog.draft = true
    elsif params[:commit] == "post"
      @blog.draft = false
      @blog.created_at = Time.now
    elsif params[:commit] == "unpost"
      @blog.draft = true
    end

    if params[:commit] == "cancel"
      redirect_to beta_test_blogs_path(current_beta_test)
    elsif @blog.update_attributes(params[:blog])
      redirect_to([current_beta_test, @blog], :notice => 'Blog was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /blogs/1
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    redirect_to beta_test_blogs_url(current_beta_test)
  end
end
