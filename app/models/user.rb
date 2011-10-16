class User < ActiveRecord::Base
  acts_as_authorization_subject  :association_name => :roles
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessor :password

  before_create :generate_email_code, :make_user_unconfirmed
  before_save :encrypt_password
  
  validates_acceptance_of :agreed_to_tos, :accept => true
  validates_confirmation_of :email, :password
  validates_format_of :email, :with => /\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b/
  validates_format_of :password, :with => /\A\S*\Z/, :message => 'can not have spaces'
  validates_length_of :password, :within => 6..20
  validates_length_of :name, :within => 3..40
  validates_presence_of :email, :password, :name
  validates_uniqueness_of :email, :case_sensitive => false
#  validates_exclusion_of :name, :in => %w(lee admin gil fred administrator betta bettatest bettatest.com fish gilfish gilthefish gil_fish gil_the_fish test tester testing developer bafilius applesquash)
  
  has_many  :my_beta_tests, :dependent => :destroy, :class_name => "BetaTest", :foreign_key => "user_id"
  has_many  :tester_stat_sheets, :dependent => :destroy
  has_many  :beta_tests, :through => :tester_stat_sheets
  has_many  :forum_posts, :dependent => :destroy
  has_many  :forum_topics, :dependent => :destroy
  has_one   :referral, :dependent => :destroy
  has_many  :referring, :class_name => "Referral", :foreign_key => "referred_by_id"
  has_one   :subscription, :dependent => :destroy
  has_many  :surveys, :through => :survey_votes
  has_and_belongs_to_many :roles
  
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

  def confirm(code)
    if code == email_code
      make_user_confirmed
    end
  end

  def make_user_confirmed
    self.has_no_roles!
    self.has_role! :user
    self.email_confirmed = true
    update
  end

  def is_admin?
    self.has_role? :admin
  end

  def logged_in!
    self.last_login = Time.now
    update
  end
end
