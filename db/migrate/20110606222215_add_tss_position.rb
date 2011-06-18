class AddTssPosition < ActiveRecord::Migration
  def self.up
    add_column :tester_stat_sheets, :position, :integer
  end

  def self.down
    remove_column :tester_stat_sheets, :position
  end
end
