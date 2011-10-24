class SubscriptionsController < ApplicationController
  load_and_authorize_resource

  # GET /subscriptions
  def index
  end

  # GET /subscriptions/1
  def show
  end

  # GET /subscriptions/new
  def new
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  def create
    @subscription.name = params[:subscription][:name]
    @subscription.stripe_card_token = params[:subscription][:stripe_card_token]
    if @subscription.save_with_payment
      redirect_to current_user, :notice => 'Thanks for subscribing!'
    else
      render :new
    end
  end

  # PUT /subscriptions/1
  def update
    binding.pry
    @subscription.name = params[:subscription][:name]
    @subscription.stripe_card_token = params[:subscription][:stripe_card_token]
    if @subscription.update_with_payment
      redirect_to(current_user, :notice => 'Subscription was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /subscriptions/1
  def destroy
    @subscription = Subscription.find(params[:id])
    redirect_to(current_user)
  end
end
