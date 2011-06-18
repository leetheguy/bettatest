require 'spec_helper'

module RoleHelpers
  def make_users_with_roles
    @unconfirmed = Factory.create :unconfirmed_user
    @naughty = Factory.create :naughty_user
    @plain = Factory.create :user
    @tester = Factory.create :tester
    @developer = Factory.create :developer
    @subscriber = Factory.create :developer
    @admin = Factory.create :admin

    @unconfirmed.has_no_roles!
    @unconfirmed.has_role! :unconfirmed
    @naughty.has_no_roles!
    @naughty.has_role! :naughty
    @plain.has_no_roles!
    @plain.has_role! :plain
    @tester.has_no_roles!
    @tester.has_role! :tester
    @developer.has_no_roles!
    @developer.has_role! :developer
    @subscriber.has_no_roles!
    @subscriber.has_role! :developer
    @subscriber.has_role! :subscriber
    @admin.has_no_roles!
    @admin.has_role! :admin
  end

  def security_response_for(user, action)
    session[:id] = user.id
    eval(action)
    response
  end
end
