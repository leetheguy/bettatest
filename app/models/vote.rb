class Vote < ActiveRecord::Base
  acts_as_authorization_object

  belongs_to :poll
  belongs_to :user

end
