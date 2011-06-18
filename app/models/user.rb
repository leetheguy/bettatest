class User < ActiveRecord::Base
  attr_accessor :password, :agreed_to_tos
  acts_as_authorization_subject  :association_name => :roles

  before_create :generate_email_code, :make_user_unconfirmed
	before_save :encrypt_password, :fix_tos
	
	validates_acceptance_of :agreed_to_tos
	validates_confirmation_of :email, :password
	validates_format_of :email, :with => /\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b/
  validates_format_of :password, :with => /\A\S*\Z/, :message => 'can not have spaces'
	validates_length_of :password, :within => 6..20
	validates_length_of :name, :within => 3..40
	validates_presence_of :email, :password, :name
	validates_uniqueness_of :email, :case_sensitive => false
  
  has_many  :my_beta_tests, :dependent => :destroy, :class_name => "BetaTest", :foreign_key => "user_id"
  has_many	:tester_stat_sheets, :dependent => :destroy
  has_many	:beta_tests, :through => :tester_stat_sheets
  has_many  :forum_posts, :dependent => :destroy
  has_many  :forum_topics, :dependent => :destroy
  has_one		:referral, :dependent => :destroy
  has_many  :referring, :class_name => "Referral", :foreign_key => "referred_by_id"
  has_one   :subscription, :dependent => :destroy
  has_and_belongs_to_many :roles
  
  def fix_tos
    self.agreed_to_tos = true if @agreed_to_tos
  end

  def self.authenticate(email, password)
  	user = find_by_email(email)
  	if user && user.confirm_password(user, password)
  		user
  	else
  		nil
  	end
  end
  
  def confirm_password(user, password)
  	user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
	end
  
  def encrypt_password
  	if password.present?
  		self.password_salt = BCrypt::Engine.generate_salt
  		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  	end
  end

  def self.all_with_role(role_name)
    Role.universal(role_name).users
  end

  def status_in_test(tss)
    if self.tester_stat_sheets.include? tss
      bt = tss.beta_test
      if tss.points < 0
        'no longer in test'
      elsif tss.points == 0
        'waiting'
      elsif tss.points < bt.active_min_pts
        'in test'
      elsif tss.points < bt.involved_min_pts
        'active'
      else
        'involved'
      end
    end
	end

  def generate_email_code
    self.email_code = 10.random_characters
  end

  def make_user_unconfirmed
    self.has_no_roles!
    self.has_role! :unconfirmed
  end

  def make_user_confirmed
    self.has_no_roles!
    self.has_role! :user
  end
end
