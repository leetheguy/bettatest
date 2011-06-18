class AddNaughtyFlagToSession < ActiveRecord::Migration
  def self.up
    add_column :sessions, :naughty, :boolean, :default => false
  end

  def self.down
    remove_column :sessions, :naughty
  end
end
