class Role < ActiveRecord::Base
  acts_as_authorization_role
  has_and_belongs_to_many :users

  def self.universal (role_name)
    Role.where(:name => role_name, :authorizable_type => nil, :authorizable_id => nil).first
  end
end
