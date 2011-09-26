class PatchTss < ActiveRecord::Migration
  def self.up
    add_column :tester_stat_sheets, :user_id, :integer
  end

  def self.down
    remove_column :tester_stat_sheets, :user_id
  end
end
