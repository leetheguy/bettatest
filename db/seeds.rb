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
Tag.all.each do |r| r.delete end
TicketCategory.all.each do |r| r.delete end
Ticket.all.each do |r| r.delete end
User.all.each do |r| r.delete end
TesterStatSheet.all.each do |r| r.delete end
Poll.all.each do |r| r.delete end
Vote.all.each do |r| r.delete end

FactoryGirl.create_list(:open_active_beta_test, 10)

FactoryGirl.create_list(:open_inactive_beta_test, 10)

testers = FactoryGirl.create_list(:user, 500)
testers.each do |tester|
  tester.make_user_confirmed
end

ca_tests = FactoryGirl.create_list(:closed_active_beta_test, 10)
ca_tests.each do |bt|
  FactoryGirl.create_list(:unpublished_blog, (rand(9)+2), :beta_test => bt)
  FactoryGirl.create_list(:published_blog, (rand(9)+2), :beta_test => bt)

  testers.sample(120).each do |tester|
    Factory.create(:tester_stat_sheet, :user => tester, :beta_test => bt)
  end

  my_stat_sheets = bt.tester_stat_sheets

  expired = TesterStatSheet.where(:beta_test_id => bt, :level => 1).sample(10)
  expired.each do |tss|
    tss.remove_points! 500
  end
  waiting = TesterStatSheet.where(:beta_test_id => bt, :level => 0)
  activated = TesterStatSheet.where(:beta_test_id => bt, :level => 1)

  activated -= active   = activated.sample(20)
  activated -= involved = activated.sample(20)

  activated.each do |tester|
    tester.add_points! rand(15)
  end
  active.each do |tester|
    tester.add_points! rand(50)+15
  end

  involved.each do |tester|
    tester.add_points! rand(50)+65
  end

  sfcs = FactoryGirl.create_list(:standard_forum_category, (rand(5)+1), :beta_test => bt)
  afcs = FactoryGirl.create_list(:active_forum_category, (rand(5)+1), :beta_test => bt)
  ifcs = FactoryGirl.create_list(:involved_forum_category, (rand(5)+1), :beta_test => bt)
  sfcs.each do |fc|
    topic = FactoryGirl.create_list(:forum_topic, (rand(5)+1), :user => activated.sample.user, :forum_category => fc)
    topic.each do |ft|
      post = FactoryGirl.create_list(:forum_post, (rand(5)+1), :user => activated.sample.user, :forum_topic => ft)
    end
  end

  afcs.each do |fc|
    topic = FactoryGirl.create_list(:forum_topic, (rand(5)+1), :user => active.sample.user, :forum_category => fc)
    topic.each do |ft|
      post = FactoryGirl.create_list(:forum_post, (rand(5)+1), :user => active.sample.user, :forum_topic => ft)
    end
  end

  ifcs.each do |fc|
    topic = FactoryGirl.create_list(:forum_topic, (rand(5)+1), :user => involved.sample.user, :forum_category => fc)
    topic.each do |ft|
      post = FactoryGirl.create_list(:forum_post, (rand(5)+1), :user => involved.sample.user, :forum_topic => ft)
    end
  end

  sps = FactoryGirl.create_list(:standard_poll, (rand(5)+1), :beta_test => bt)
  aps = FactoryGirl.create_list(:active_poll, (rand(5)+1), :beta_test => bt)
  ips = FactoryGirl.create_list(:involved_poll, (rand(5)+1), :beta_test => bt)
  sps.each do |p|
    rand(5)+1.times do
      Vote.create(:user => activated.sample.user, :poll => p, :option => rand(p.options.count))
    end
  end

  aps.each do |p|
    rand(5)+1.times do
      Vote.create(:user => activated.sample.user, :poll => p, :option => rand(p.options.count))
    end
  end

  ips.each do |p|
    rand(5)+1.times do
      Vote.create(:user => activated.sample.user, :poll => p, :option => rand(p.options.count))
    end
  end
end

FactoryGirl.create_list(:closed_inactive_beta_test, 10)

admin = Factory.create(:user, :email => 'lee@bettatest.com', :betta_email_opt_in => true, :name => 'lee')

admin.make_user_confirmed
admin.has_role! :admin
