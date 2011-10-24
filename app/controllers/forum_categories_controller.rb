class ForumCategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @forum_categories = @forum_categories.page(params[:page]).per(20)
  end

  def show
    redirect_to forum_topics_path(:forum_category_id => @forum_category)
  end

  def new
  end

  def edit
  end

  def create
    if params[:commit] == "cancel"
      redirect_to forum_categories_path
    elsif @forum_category.save
      redirect_to forum_topics_path(:forum_category_id => @forum_category), :notice => 'Forum category was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    if params[:commit] == "cancel"
      redirect_to forum_categories_path
    else
      if @forum_category.update_attributes(params[:forum_category])
        redirect_to forum_categories_path, :notice => 'Forum category was successfully updated.'
      else
        render :action => "edit"
      end
    end
  end

  def destroy
    @forum_category.destroy
    redirect_to forum_categories_path
  end
end
