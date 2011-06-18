require 'spec_helper'

describe Role do
  let!(:user) { Factory.create :user }
  describe "finders" do
    it "returns a single role for users with universal access" do
      user.has_role! :admin
      Role.universal(:admin).name.should == 'admin'
    end
  end
end
