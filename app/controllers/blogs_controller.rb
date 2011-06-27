class BlogsController < ApplicationController
  skip_before_filter :clear_beta_test
  before_filter :current_beta_test, :only => [:edit, :update]

  access_control do
    allow all, :to => [:index, :show]
    allow :developer, :of => :current_beta_test, :to => [:new, :edit, :create, :update, :destroy]
    allow :admin
  end

  # GET /blogs
  def index
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

    if @blog.save
      redirect_to(@blog, :notice => 'Blog was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /blogs/1
  def update
    @blog = Blog.find(params[:id])

    respond_to do |format|
      if @blog.update_attributes(params[:blog])
        format.html { redirect_to(@blog, :notice => 'Blog was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to(blogs_url) }
      format.xml  { head :ok }
    end
  end
end
