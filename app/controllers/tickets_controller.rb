class TicketsController < ApplicationController
  before_filter :current_beta_test, :current_ticket_category
  before_filter :involved_only, :active_only

  access_control do
    allow :developer, :of => :current_beta_test
    allow :admin
  end

  # GET /tickets
  # GET /tickets.xml
  def index
    @tickets = Ticket.where(:ticket_category => :current_ticket_category)
  end

  # GET /tickets/1
  # GET /tickets/1.xml
  def show
    @ticket = Ticket.find(params[:id])
  end

  # GET /tickets/new
  # GET /tickets/new.xml
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end

  # POST /tickets
  # POST /tickets.xml
  def create
    @ticket = Ticket.new(params[:ticket])

    if @ticket.save
      redirect_to(@ticket, :notice => 'Ticket was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.xml
  def update
    @ticket = Ticket.find(params[:id])

    if @ticket.update_attributes(params[:ticket])
      redirect_to(@ticket, :notice => 'Ticket was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.xml
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    redirect_to(tickets_url)
  end
end
