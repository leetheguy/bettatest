class CreateBetaTests < ActiveRecord::Migration
  def self.up
    create_table :beta_tests do |t|
      t.string  :test_name,                   :null => false
      t.integer :max_testers,         				:default => 100
      t.integer :starting_points,     				:default => 100
      t.integer :active_min_pts,      				:default => 250
      t.integer :involved_min_pts,    				:default => 750
      t.integer :daily_drop_pts,      				:default => 100
      t.integer :daily_login_pts,     				:default => 100
      t.integer :forum_post_pts,      				:default => 300
      t.integer :rate_up_lose_pts,    				:default => 100
      t.integer :rate_up_give_pts,    				:default => 200
      t.integer :rate_down_lose_pts,  				:default => 200
      t.integer :rate_down_take_pts,  				:default => 100
      t.integer :survey_vote_pts,     				:default => 300
      t.integer :tester_days_to_gift, 				:default => 0
      t.integer :active_days_to_gift, 				:default => 0
      t.integer :involved_days_to_gift,       :default => 10
      t.boolean :involved_can_merge_tickets,  :default => true
      t.boolean :involved_can_add_tickets,    :default => false
      
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :beta_tests
  end
end
