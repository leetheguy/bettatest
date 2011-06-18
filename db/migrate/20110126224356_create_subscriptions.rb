class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.decimal :low_tier_price, :precision => 3, :scale => 2, :default => 14.00
      t.decimal :high_tier_price, :precision => 3, :scale => 2, :default => 6.00
      t.decimal :low_tier_year_price, :precision => 3, :scale => 2, :default => 149.00
      t.decimal :high_tier_year_price, :precision => 3, :scale => 2, :default => 299.00
      t.integer :low_tier_months_left, :default => 0    #tier 1
      t.integer :high_tier_months_left, :default => 0   #tier 2
      t.integer :current_tier, :default => 0
      
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
