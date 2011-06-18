require 'test_helper'

class SessionTest < ActiveSupport::TestCase
#  setup do
#    @session = Factory.build :session
#    @all_true = Factory.build :session, :visitor => true, :unconfirmed_user => true, :plain_user => true, :tester => true, :developer => true, :admin => true
#  end
#
#  test "unconfirmed users are unconfirmed users" do
#    u = Factory.create :unconfirmed_user
#    s = Factory.create :session, :user => u
#    assert_equal s.unconfirmed_user, true, "unconfirmed users are not unconfirmed users"
#  end
#
#  test "naughty users are naughty users" do
#    u = Factory.create :naughty_user
#    s = Factory.create :session, :user => u
#    assert_equal s.naughty, true, "naughty users are not naughty users"
#  end
#    
#  test "plain users are plain users" do
#    u = Factory.create :user
#    s = Factory.create :session, :user => u
#    assert_equal s.plain_user, true, "plain users are not plain users"
#  end
#
#  test "testers are testers" do
#    bt = Factory.create :beta_test
#    t = Factory.create :tester
#    tss = Factory.create :tester_stat_sheet, :user => t, :beta_test => bt
#    s = Factory.create :session, :user => t
#    assert_equal s.tester, true, "testers are not testers"
#  end
#
#  test "developers are developers" do
#    d = Factory.create :developer
#    bt = Factory.create :beta_test, :user => d
#    s = Factory.create :session, :user => d
#    assert_equal s.developer, true, "developers are not developers"
#  end
#
#  test "admins are admins" do
#    a = Factory.create :admin
#    s = Factory.create :session, :user => a
#    assert_equal s.admin, true, "admins are not admins"
#  end
#
#  test "users can be testers and developers" do
#    obt = Factory.create :beta_test
#    tdu = Factory.create :user
#    tss = Factory.create :tester_stat_sheet, :user => tdu
#    mbt = Factory.create :beta_test, :user => tdu
#    s = Factory.create :session, :user => tdu
#    assert_equal s.tester, true, "user not a tester"
#    assert_equal s.developer, true, "user not a developer"
#  end
#
#  test "users can be testers and admins" do
#    obt = Factory.create :beta_test
#    tau = Factory.create :admin
#    tss = Factory.create :tester_stat_sheet, :user => tau
#    s = Factory.create :session, :user => tau
#    assert_equal s.tester, true, "user not a tester"
#    assert_equal s.admin, true, "user not an admin"
#  end
#
#  test "users can be developers and admins" do
#    tdu = Factory.create :admin
#    mbt = Factory.create :beta_test, :user => tdu
#    s = Factory.create :session, :user => tdu
#    assert_equal s.developer, true, "user not a developer"
#    assert_equal s.admin, true, "user not an admin"
#  end
#
#  test "users can be testers, developers and admins" do
#    obt = Factory.create :beta_test
#    tsu = Factory.create :admin
#    tss = Factory.create :tester_stat_sheet, :user => tsu
#    mbt = Factory.create :beta_test, :user => tsu
#    s = Factory.create :session, :user => tsu
#    assert_equal s.tester, true, "user not a tester"
#    assert_equal s.developer, true, "user not a developer"
#    assert_equal s.admin, true, "user not an admin"
#  end
#
#  test "user_is_visitor sets appropriate flags" do
#    current_user_session = @all_true
#    current_user_session.user_is_visitor
#    assert_equal current_user_session.unconfirmed_user, false, "unconfirmed_user flag not false"
#    assert_equal current_user_session.plain_user, false, "plain_user flag not false"
#    assert_equal current_user_session.tester, false, "tester lag user not false"
#    assert_equal current_user_session.developer, false, "developer flag not false"
#    assert_equal current_user_session.admin, false, "admin flag not false"
#    assert_equal current_user_session.visitor, true, "visitor flag not true"
#  end
#
#  test "user_is_unconfirmed_user sets appropriate flags" do
#    current_user_session = @all_true
#    current_user_session.user_is_unconfirmed_user
#    assert_equal current_user_session.visitor, false, "visitor flag not false"
#    assert_equal current_user_session.plain_user, false, "plain_user flag not false"
#    assert_equal current_user_session.tester, false, "tester lag user not false"
#    assert_equal current_user_session.developer, false, "developer flag not false"
#    assert_equal current_user_session.admin, false, "admin flag not false"
#    assert_equal current_user_session.unconfirmed_user, true, "visitor flag not true"
#  end
#
#  test "naughty users are naughty" do
#    u = Factory.create :naughty_user
#    s = Factory.create :session, :user => u
#    assert_equal s.user_is_naughty, true, "user is getting a present from santa"
#  end
#
#  test "user_is_naughty sets appropriate flags" do
#    current_user_session = @all_true
#    current_user_session.user_is_naughty
#    assert_equal current_user_session.visitor, false, "visitor flag not false"
#    assert_equal current_user_session.plain_user, false, "plain_user flag not false"
#    assert_equal current_user_session.unconfirmed_user, false, "plain_user flag not false"
#    assert_equal current_user_session.tester, false, "tester lag user not false"
#    assert_equal current_user_session.developer, false, "developer flag not false"
#    assert_equal current_user_session.admin, false, "admin flag not false"
#    assert_equal current_user_session.naughty, true, "visitor flag not true"
#  end
#
#  test "user_is_plain_user sets appropriate flags" do
#    current_user_session = @all_true
#    current_user_session.user_is_plain_user
#    assert_equal current_user_session.visitor, false, "visitor flag not false"
#    assert_equal current_user_session.unconfirmed_user, false, "unconfirmed_user flag not false"
#    assert_equal current_user_session.tester, false, "tester lag user not false"
#    assert_equal current_user_session.developer, false, "developer flag not false"
#    assert_equal current_user_session.admin, false, "admin flag not false"
#    assert_equal current_user_session.plain_user, true, "visitor flag not true"
#  end
#
#  test "user_is_tester sets appropriate flags" do
#    current_user_session = @all_true
#    current_user_session.user_is_tester
#    assert_equal current_user_session.visitor, false, "visitor flag not false"
#    assert_equal current_user_session.unconfirmed_user, false, "unconfirmed_user flag not false"
#    assert_equal current_user_session.plain_user, false, "plain_user flag not false"
#    assert_equal current_user_session.tester, true, "visitor flag not true"
#  end
#
#  test "user_is_developer sets appropriate flags" do
#    current_user_session = @all_true
#    current_user_session.user_is_developer
#    assert_equal current_user_session.visitor, false, "visitor flag not false"
#    assert_equal current_user_session.unconfirmed_user, false, "unconfirmed_user flag not false"
#    assert_equal current_user_session.plain_user, false, "plain_user flag not false"
#    assert_equal current_user_session.developer, true, "visitor flag not true"
#  end
#
#  test "user_is_admin sets appropriate flags" do
#    current_user_session = @all_true
#    current_user_session.user_is_admin
#    assert_equal current_user_session.visitor, false, "visitor flag not false"
#    assert_equal current_user_session.unconfirmed_user, false, "unconfirmed_user flag not false"
#    assert_equal current_user_session.plain_user, false, "plain_user flag not false"
#    assert_equal current_user_session.admin, true, "visitor flag not true"
#  end
end
