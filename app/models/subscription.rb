class Subscription < ActiveRecord::Base
  acts_as_authorization_object
  attr_accessor :stripe_card_token

  before_create :adjust_roles
	
  belongs_to :user

  @@plans = { 'alpmon' => 'alpha release special - $19 per month',
              'alpyea' => 'alpha release special - $199 per year' } 

  @@other_plans = { 'betmon' => 'beta release special - $29 per year',
                    'betyea' => 'beta release special - $299 per year',
                    'stamon' => 'standard rate - $39 per year',
                    'stayea' => 'standard rate - $399 per year' }

  def self.plans
    @@plans
  end

  def adjust_roles
    self.user.has_role! :subscriber
  end

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(:card => stripe_card_token,
                                         :email => user.email,
                                         :description => user.name,
                                         :plan => name)
      self.stripe_customer_token = customer.id
      user.has_role!(:subscriber)
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def update_with_payment
    if valid?
      customer = Stripe::Customer.retrieve(stripe_customer_token)
      customer.card = stripe_card_token
      customer.email = user.email
      customer.description = user.name
      customer.plan = name
      customer.save
      user.has_no_role!(:subscriber)
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while updating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
  end
end
