task :cron => :environment do
  TesterStatSheet.daily_adjustment
#  if Time.now.hour % 4 == 0 # run every four hours
#    puts "Updating feed..."
#    NewsFeed.update
#    puts "done."
#  end
#
#  if Time.now.hour == 0 # run at midnight
#    User.send_reminders
#  end
end
