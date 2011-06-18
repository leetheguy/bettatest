class CreateTesterStats < ActiveRecord::Migration
  def self.up
    create_table :tester_stats do |t|
      t.integer :level, :default => 0
      t.integer :points, :default => 0
      t.integer :days_at_level, :default => 0

      t.references :user
      t.references :beta_test
  
      t.timestamps
    end
  end

  def self.down
    drop_table :tester_stats
  end
end
