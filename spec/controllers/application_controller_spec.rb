require 'spec_helper'

RSpec.configure do |c|
  c.include RoleHelpers
end

describe ApplicationController do
  before do
    make_users_with_roles
  end
  it "creates a current user based on session id" do
    session[:id] = @plain.id
#    @current_user.id.should == @plain.id
  end
end
