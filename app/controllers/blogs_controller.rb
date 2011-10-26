class BlogsController < ApplicationController
  load_and_authorize_resource :except => [:feed, :unpublished, :index]

  def feed
    bt = BetaTest.find(params[:id])
    @blogs = bt.blogs.where(:draft => false).order('created_at DESC')
    @title = "the blog of the bettatest for #{bt.name}"
    @updated = @blogs.first.updated_at unless @blogs.empty?
    @author 

    respond_to do |format|
      format.atom { render :layout => false }
      format.rss { redirect_to beta_test_feed_path(:format => :atom), :status => :moved_permanently }
    end
  end

  def unpublished
    authorize! :unpublished, Blog
    @blogs = current_beta_test.blogs.where(:draft => true).order('created_at DESC').page(params[:page]).per(10)
    @published = false
    render :action => :index
  end

  # GET /blogs
  def index
    authorize! :read, Blog
    @blogs = current_beta_test.blogs.where(:draft => false).order('created_at DESC').page(params[:page]).per(10)
    @published = true
  end

  # GET /blogs/1
  def show
  end

  # GET /blogs/new
  def new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  def create
    @published = true
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
    @published = true
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
    @blog.destroy
    redirect_to blogs_path
  end
end
