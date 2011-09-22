class Survey < ActiveRecord::Base
  acts_as_authorization_object

	attr_accessible :name, :description, :access_level
	
  validates_presence_of :name
  validates_length_of :name, :maximum => 50
  validates_length_of :description, :maximum => 200
  validates_numericality_of :access_level, :only_integer => true, :greater_than => 0, :less_than => 4
  
  has_many :survey_options, :dependent => :destroy
  has_many :users, :through => :survey_votes
  belongs_to :beta_test

  def involved_only
    self.access_level == 3
  end

  def active_only
    self.access_level == 2
  end

  def activated_only
    self.access_level == 1
  end

  def Survey.involved
    3
  end

  def Survey.active
    2
  end
  
  def Survey.activated
    1
  end

  def self.surveys_for(user, beta_test)
    if user.has_role? :admin
      Survey.where(:beta_test_id => beta_test.id)
    else
      level = TesterStatSheet.where(:beta_test_id => beta_test.id, 
                                    :user_id => user.id).first.level
      Survey.where('access_level < ?', level)
    end
  end
end
