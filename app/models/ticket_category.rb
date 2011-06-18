class TicketCategory < ActiveRecord::Base
  acts_as_authorization_object

	attr_accessible :name, :description
	
	validates_presence_of :name
  validates_length_of :name, :maximum => 50
  validates_length_of :description, :maximum => 200
  
  belongs_to :beta_test
  has_many :tickets, :dependent => :destroy

  def involved_only
    self.access_level == 3
  end

  def active_only
    self.access_level == 2
  end

  def activated_only
    self.access_level == 1
  end

  def TicketCategory.involved
    3
  end

  def TicketCategory.active
    2
  end
  
  def TicketCategory.activated
    1
  end
end
