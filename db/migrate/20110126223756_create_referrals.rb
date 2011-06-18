class CreateReferrals < ActiveRecord::Migration
  def self.up
    create_table :referrals do |t|
      t.string :referred_by 
      t.integer :reward_at, :default => 3
      t.integer :rewards_given, :default => 0
      
      t.references :user
      
      t.timestamps
    end
  end

  def self.down
    drop_table :referrals
  end
end
