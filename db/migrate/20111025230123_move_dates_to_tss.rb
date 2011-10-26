class MoveDatesToTss < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.remove :daily_pt_taken, :daily_pt_given
    end
    change_table :tester_stat_sheets do |t|
      t.date :daily_pts_taken, :daily_pts_given
    end
  end

  def self.down
    change_table :tester_stat_sheets do |t|
      t.remove :daily_pts_taken, :daily_pts_given
    end
    change_table :users do |t|
      t.date :daily_pt_taken, :daily_pt_given
    end
  end
end
