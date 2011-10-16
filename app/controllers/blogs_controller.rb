class BlogsController < ApplicationController
  skip_before_filter :clear_beta_test

  access_control do
    allow all, :to => [:index, :show, :feed]
    allow :developer, :of => :current_beta_test
    allow :admin
  end

  def feed
    @blogs = current_beta_test.blogs.where(:draft => false).order('created_at DESC').page(params[:page]).per(10)
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
    @blogs = current_beta_test.blogs.where(:draft => true).order('created_at DESC').page(params[:page]).per(10)
    render :action => :index
  end

  # GET /blogs
  def index
    @published = true
    @blogs = current_beta_test.blogs.where(:draft => false).order('created_at DESC').page(params[:page]).per(10)
  end

  # GET /blogs/1
  def show
    @blog = Blog.find(params[:id])
    if @blog.draft && !(current_user.has_role?(:developer, current_beta_test) || current_user.has_role?(:admin))
      redirect_to current_beta_test
    end
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

    if params[:commit] == 'save'
      @blog.draft = true
      flash[:notice] = 'Blog was successfully saved but not published.'
    elsif params[:commit] == 'publish'
      @blog.draft = false
      @blog.created_at = Time.now
      flash[:notice] = 'Blog was successfully published.'
    end

    if params[:commit] == 'cancel'
      redirect_to blogs_path
    elsif @blog.save
      redirect_to @blog
    else
      render :action => 'new'
    end
  end

  # PUT /blogs/1
  def update
    @blog = Blog.find(params[:id])
    if params[:commit] == 'unpublish'
      @blog.draft = true
      flash[:notice] = 'Blog was successfully saved and not published.'
    elsif params[:commit] == 'publish'
      @blog.draft = false
      @blog.created_at = Time.now
      flash[:notice] = 'Blog was successfully published.'
    elsif params[:commit] == 'save'
      flash[:notice] = 'Blog was successfully updated.'
    end

    if params[:commit] == 'cancel'
      redirect_to blogs_path
    elsif @blog.update_attributes(params[:blog])
      redirect_to @blog
    else
      render :action => 'edit'
    end
  end

  # DELETE /blogs/1
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    redirect_to blogs_path
  end
end
