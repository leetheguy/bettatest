class DropTesterPosition < ActiveRecord::Migration
  def self.up
    remove_column :tester_stat_sheets, :position
  end

  def self.down
    add_column :tester_stat_sheets, :position, :integer
  end
end
