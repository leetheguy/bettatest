class TicketCategoriesController < ApplicationController
  before_filter :current_beta_test, :current_ticket_category
  before_filter :involved_only, :active_only

  access_control do
    allow :developer, :of => :current_beta_test
    allow :admin
  end

  # GET /ticket_categories
  # GET /ticket_categories.xml
  def index
    @ticket_categories = TicketCategory.where(:beta_test => :current_beta_test)
  end

  # GET /ticket_categories/1
  # GET /ticket_categories/1.xml
  def show
    @ticket_category = TicketCategory.find(params[:id])
  end

  # GET /ticket_categories/new
  # GET /ticket_categories/new.xml
  def new
    @ticket_category = TicketCategory.new
  end

  # GET /ticket_categories/1/edit
  def edit
    @ticket_category = TicketCategory.find(params[:id])
  end

  # POST /ticket_categories
  # POST /ticket_categories.xml
  def create
    @ticket_category = TicketCategory.new(params[:ticket_category])

    if @ticket_category.save
      redirect_to(@ticket_category, :notice => 'Ticket category was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /ticket_categories/1
  # PUT /ticket_categories/1.xml
  def update
    @ticket_category = TicketCategory.find(params[:id])

    if @ticket_category.update_attributes(params[:ticket_category])
      redirect_to(@ticket_category, :notice => 'Ticket category was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /ticket_categories/1
  # DELETE /ticket_categories/1.xml
  def destroy
    @ticket_category = TicketCategory.find(params[:id])
    @ticket_category.destroy

    redirect_to(ticket_categories_url)
  end
end
