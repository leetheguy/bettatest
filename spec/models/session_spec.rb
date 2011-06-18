require 'spec_helper'

describe Session do
#  let(:session) { Factory.build :session }
#  let(:unconfirmed_user) { Factory.build :unconfirmed_user }
#  let(:naughty_user) { Factory.build :naughty_user }
#  let(:plain_user) { Factory.build :user }
#  let(:tester) { Factory.build :tester }
#  let(:developer) { Factory.build :developer }
#  let(:admin) { Factory.build :admin }
#  let(:tester_developer) { Factory.build :user }
#  let(:tester_admin) { Factory.build :admin }
#  let(:developer_admin) { Factory.build :admin }
#  let(:tester_developer_admin) { Factory.build :admin }
#  let(:beta_test) { Factory.build :beta_test, :user => developer }
#  let(:tester_stat_sheet) { Factory.build :tester_stat_sheet, :beta_test => beta_test, :user => tester }
#  let(:td_beta_test) { Factory.build :beta_test, :user => tester_developer }
#  let(:td_tester_stat_sheet) { Factory.build :tester_stat_sheet, :beta_test => td_beta_test, :user => tester_developer }
#  let(:a_tester_stat_sheet) { Factory.build :tester_stat_sheet, :beta_test => beta_test, :user => tester_admin }
#  let(:a_beta_test) { Factory.build :beta_test, :user => developer_admin }
#  let(:tda_beta_test) { Factory.build :beta_test, :user => tester_developer_admin }
#  let(:tda_tester_stat_sheet) { Factory.build :tester_stat_sheet, :beta_test => tda_beta_test, :user => tester_developer_admin }

#    before :each do
#      tester.save!
#      developer.save!
#      beta_test.save!
#      tester_stat_sheet.user = tester
#      tester_stat_sheet.beta_test = beta_test
#      tester_stat_sheet.user = tester
#      tester_stat_sheet.save!
#    end

#  it "sets flags for visitors" do
#    session.user = nil
#    session.save!
#    session.visitor.should be_true
#    session.unconfirmed_user.should be_false
#    session.naughty.should be_false
#    session.plain_user.should be_false
#    session.tester.should be_false
#    session.developer.should be_false
#    session.admin.should be_false
#  end
#
#  it "sets flags for unconfirmed users" do
#    session.user = unconfirmed_user
#    session.save!
#    session.visitor.should be_false
#    session.unconfirmed_user.should be_true
#    session.naughty.should be_false
#    session.plain_user.should be_false
#    session.tester.should be_false
#    session.developer.should be_false
#    session.admin.should be_false
#  end
#
#  it "sets flags for naughty users" do
#    session.user = naughty_user 
#    session.save!
#    session.visitor.should be_false
#    session.unconfirmed_user.should be_false
#    session.naughty.should be_true
#    session.plain_user.should be_false
#    session.tester.should be_false
#    session.developer.should be_false
#    session.admin.should be_false
#  end
#
#  it "sets flags for plain users" do
#    session.user = plain_user 
#    session.save!
#    session.visitor.should be_false
#    session.unconfirmed_user.should be_false
#    session.naughty.should be_false
#    session.plain_user.should be_true
#    session.tester.should be_false
#    session.developer.should be_false
#    session.admin.should be_false
#  end
#
#  it "sets flags for testers" do
#    tester.save!
#    beta_test.save!
#    tester_stat_sheet.save!
#    session.user = tester
#    session.save!
#    session.visitor.should be_false
#    session.unconfirmed_user.should be_false
#    session.naughty.should be_false
#    session.plain_user.should be_false
#    session.tester.should be_true
#    session.developer.should be_false
#    session.admin.should be_false
#  end
#
#  it "sets flags for developers" do
#    beta_test.save!
#    developer.save!
#    session.user = developer
#    session.save!
#    session.visitor.should be_false
#    session.unconfirmed_user.should be_false
#    session.naughty.should be_false
#    session.plain_user.should be_false
#    session.tester.should be_false
#    session.developer.should be_true
#    session.admin.should be_false
#  end
#
#  it "sets flags for admins"  do
#    session.user = admin
#    session.save!
#    session.visitor.should be_false
#    session.unconfirmed_user.should be_false
#    session.naughty.should be_false
#    session.plain_user.should be_false
#    session.tester.should be_false
#    session.developer.should be_false
#    session.admin.should be_true
#  end
#
#  it "sets flags for tester developers" do
#    td_beta_test.save!
#    td_tester_stat_sheet.save!
#    tester_developer.save!
#    session.user = tester_developer 
#    session.save!
#    session.visitor.should be_false
#    session.unconfirmed_user.should be_false
#    session.naughty.should be_false
#    session.plain_user.should be_false
#    session.tester.should be_true
#    session.developer.should be_true
#    session.admin.should be_false
#  end
#
#  it "sets flags for tester admins" do
#    beta_test.save!
#    a_tester_stat_sheet.save!
#    tester_admin.save!
#    session.user = tester_admin
#    session.save!
#    session.visitor.should be_false
#    session.unconfirmed_user.should be_false
#    session.naughty.should be_false
#    session.plain_user.should be_false
#    session.tester.should be_true
#    session.developer.should be_false
#    session.admin.should be_true
#  end
#
#  it "sets flags for developer admins" do
#    a_beta_test.save!
#    developer_admin.save!
#    session.user = developer_admin 
#    session.save!
#    session.visitor.should be_false
#    session.unconfirmed_user.should be_false
#    session.naughty.should be_false
#    session.plain_user.should be_false
#    session.tester.should be_false
#    session.developer.should be_true
#    session.admin.should be_true
#  end
#
#  it "sets flags for tester developer admins" do
#    tda_beta_test.save!
#    tda_tester_stat_sheet.save!
#    tester_developer_admin.save!
#    session.user = tester_developer_admin
#    session.save!
#    session.visitor.should be_false
#    session.unconfirmed_user.should be_false
#    session.naughty.should be_false
#    session.plain_user.should be_false
#    session.tester.should be_true
#    session.developer.should be_true
#    session.admin.should be_true
#  end
end
