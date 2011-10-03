# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => "Chicago" }, { :name => "Copenhagen" }])
#   Mayor.create(:name => "Daley", :city => cities.first)
												
#Role.create([{ :name => :unconfirmed }, { :name => :naughty }, { :name => :plain }, { :name => :tester }, { :name => :developer }, { :name => :admin }])


BetaTest.all.each do |r| r.delete end
Blog.all.each do |r| r.delete end
ForumCategory.all.each do |r| r.delete end
ForumTopic.all.each do |r| r.delete end
ForumPost.all.each do |r| r.delete end
Referral.all.each do |r| r.delete end
Subscription.all.each do |r| r.delete end
Survey.all.each do |r| r.delete end
SurveyOption.all.each do |r| r.delete end
Tag.all.each do |r| r.delete end
TicketCategory.all.each do |r| r.delete end
Ticket.all.each do |r| r.delete end
User.all.each do |r| r.delete end
TesterStatSheet.all.each do |r| r.delete end

FactoryGirl.create_list(:open_active_beta_test, 10)

FactoryGirl.create_list(:open_inactive_beta_test, 10)

ca_tests = FactoryGirl.create_list(:closed_active_beta_test, 10)
ca_tests.each do |bt|
  FactoryGirl.create_list(:unpublished_blog, (rand(9)+2), :beta_test => bt)
  FactoryGirl.create_list(:published_blog, (rand(9)+2), :beta_test => bt)

  testers = FactoryGirl.create_list(:user, 120)
  testers.each do |tester|
    Factory.create(:tester_stat_sheet, :user => tester, :beta_test => bt)
  end

  sfcs = FactoryGirl.create_list(:standard_forum_category, (rand(5)+1), :beta_test => bt)
  afcs = FactoryGirl.create_list(:active_forum_category, (rand(5)+1), :beta_test => bt)
  ifcs = FactoryGirl.create_list(:involved_forum_category, (rand(5)+1), :beta_test => bt)
end


#    (rand(10+1).times do
#      ft = FactoryGirl.create(:forum_topic, :beta_test => bt, :forum_category => fc)
#      (rand(10+1).times do
#        ft = FactoryGirl.create(:forum_topic, :beta_test => bt, :forum_category => fc)
#      end
#    end
#  end
#
#  (rand(5)+1).times do
#    FactoryGirl.create(:active_forum_category, :beta_test => bt)
#    (rand(10+1).times do
#      ft = FactoryGirl.create(:forum_topic, :beta_test => bt, :forum_category => fc)
#    end
#  end
#
#  (rand(5)+1).times do
#    FactoryGirl.create(:involved_forum_category, :beta_test => bt)
#    (rand(10+1).times do
#      ft = FactoryGirl.create(:forum_topic, :beta_test => bt, :forum_category => fc)

FactoryGirl.create_list(:closed_inactive_beta_test, 10)

#unconfirmed_users = FactoryGirl.create_list(:unconfirmed_user, 10)
#
#naughty_users = FactoryGirl.create_list(:naughty_user, 10)
#
#users = FactoryGirl.create_list(:user, 10)
#users.each do |t|
#  t.make_user_confirmed
#end
#
#developers = FactoryGirl.create_list(:user, 10)
#developers.each do |t|
#  Factory.create :beta_test, :user => t
#end
#
#BetaTest.all.each do |t|
#  testers = FactoryGirl.create_list(:user, rand(50)+80, :beta_test => t)
#end
#
#admin = Factory.create(:user, :email => 'lee@bettatest.com', :betta_email_opt_in => true, :name => 'lee')






