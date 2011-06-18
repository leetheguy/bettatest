class RenameTesterStats < ActiveRecord::Migration
  def self.up
  	rename_table :tester_stats, :tester_stat_sheets
  end

  def self.down
  	rename_table :tester_stat_sheets, :tester_stats
  end
end
