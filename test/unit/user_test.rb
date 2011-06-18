require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
   @user = Factory.build :user
  end

  test "standard validations" do
    no_password_space = Factory.build :user, :password => 'password space'
    assert no_password_space.invalid?, no_password_space.errors.to_s

    bad_email = Factory.build :user, :email => 'bad email'
    assert bad_email.invalid?, bad_email.errors.to_s

    long_password = Factory.build :user, :password => 'PasswordIsTooLongTrustMe'
    assert long_password.invalid?, long_password.errors.to_s

    short_password = Factory.build :user, :password => 'pass'
    assert short_password.invalid?, short_password.errors.to_s

    long_name = Factory.build :user, :name => 'this is a really really totally stupid ridiculously long name for a user that no one will ever remember'
    assert long_name.invalid?, long_name.errors.to_s

    short_name = Factory.build :user, :name => 'n'
    assert short_name.invalid?, short_name.errors.to_s

    no_name = Factory.build :user, :name => ''
    assert no_name.invalid?, no_name.errors.to_s

    no_password = Factory.build :user, :password => ''
    assert no_password.invalid?, no_password.errors.to_s

    no_email = Factory.build :user, :email => ''
    assert no_email.invalid?, no_email.errors.to_s

    @user.save!
    duplicate_email = Factory.build :user, :email => @user.email
    assert duplicate_email.invalid?, duplicate_email.errors.to_s

    tos_accepted = Factory.build :user, :agreed_to_tos => '0'
    assert tos_accepted.invalid?, tos_accepted.errors.to_s

    email_confirmed = Factory.build :user, :email_confirmation => 'wrong@email.foo'
    assert email_confirmed.invalid?, email_confirmed.errors.to_s

    password_confirmed = Factory.build :user, :password_confirmation => 'Wrong_Password'
    assert password_confirmed.invalid?, password_confirmed.errors.to_s
  end
end
