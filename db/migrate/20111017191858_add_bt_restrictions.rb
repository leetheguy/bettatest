class AddBtRestrictions < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.date :daily_pt_taken, :daily_pt_given
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :daily_pt_taken, :daily_pt_given
    end
  end
end
