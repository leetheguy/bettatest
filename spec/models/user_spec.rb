require 'spec_helper'

describe User do
  before do
    make_users_with_roles
  end

  describe "todo list" do
    it "doesn't allow user deletion"
    it "returns suspension time for a positive number"
    it "returns no suspension time for 0"
    it "returns permanent suspension for -1"
    it "validates that the user name doesn't contain a reserved word"
  end

  describe "before create" do
    let!(:user) { Factory.create :user }

    it "generates an email code" do
      user.email_code.length.should be > 0
    end

    it "assigns the new user to be only unconfirmed" do
      user.has_role?(:unconfirmed).should be_true
    end

    it "sends a confirmation email to the new user"
  end

  describe "functionality" do
    it "returns arrays of users" do
      User.all_with_role(:unconfirmed).class.should == Array
      User.all_with_role(:unconfirmed).each do |user|
        user.has_role?(:unconfirmed).should be_true
      end
      User.all_with_role(:naughty).each do |user|
        user.has_role?(:naughty).should be_true
      end
      User.all_with_role(:plain).each do |user|
        user.has_role?(:plain).should be_true
      end
      User.all_with_role(:tester).each do |user|
        user.has_role?(:tester).should be_true
      end
      User.all_with_role(:developer).each do |user|
        user.has_role?(:developer).should be_true
      end
      User.all_with_role(:admin).each do |user|
        user.has_role?(:admin).should be_true
      end
    end
  end

  describe "validations" do
    let(:model) { Factory.build :user }

    it "won't accept spaces in the password" do
      model.password = 'password space'
      model.should be_invalid
    end

    it "wont accept bad emails" do
      model.email = 'bad email'
      model.should be_invalid
    end

    it "won't accept passwords that are too long" do
      model.password = 'PasswordIsTooLongTrustMe'
      model.should be_invalid
    end

    it "won't accept passwords that are too short either" do
      model.password = 'pass'
      model.should be_invalid
    end

    it "expects a reasonably short name" do
      model.name = 'this is a really really totally stupid ridiculously long name for a model that no one will ever remember'
      model.should be_invalid
    end

    it "expects a reasonably long name too" do
      model.name = 'n'
      model.should be_invalid
    end

    it "needs a name" do
      model.name = ''
      model.should be_invalid
    end

    it "needs a password too" do
      model.password = ''
      model.should be_invalid
    end

    it "needs an email" do
      model.email = ''
      model.should be_invalid
    end

    it "prevents duplicate emails" do
      model.save!
      dup = Factory.build :user, :email => model.email
      dup.should be_invalid
    end

    it "prevents duplicate names too" do
      pending
      model.save!
      dup = Factory.build :user, :name => model.name
      dup.should be_invalid
    end

    it "needs terms of service to be agreed to" do
      model.agreed_to_tos = '0'
      model.should be_invalid
    end

    it "won't accept an inaccurate confirmation email" do
      model.email_confirmation = 'wrong@email.foo'
      model.should be_invalid
    end

    it "won't accept an inaccurate confirmation password either" do
      model.password_confirmation = 'Wrong_Password'
      model.should be_invalid
    end

    it "makes user confirmed if email code matches" do
      model.confirm(model.email_code)
      model.should have_role :user
    end

    it "should restrict access to password hash"
    it "should restrict access to password salt"
    it "converts days of suspension to time for inactive_until"
    it "it fills in user id of referral (if available) upon creation"
  end
end
