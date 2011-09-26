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
Forum_Post.all.each do |r| r.delete end
Referral.all.each do |r| r.delete end
Subscription.all.each do |r| r.delete end
Survey.all.each do |r| r.delete end
SurveyOption.all.each do |r| r.delete end
Tag.all.each do |r| r.delete end
TesterStatSheet.all.each do |r| r.delete end
TicketCategory.all.each do |r| r.delete end
Ticket.all.each do |r| r.delete end
User.all.each do |r| r.delete end

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






