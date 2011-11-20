class Poll < ActiveRecord::Base
  acts_as_authorization_object

  serialize  :options, Array

  belongs_to :beta_test
  has_many   :votes
  has_many   :users, :through => :votes

end
