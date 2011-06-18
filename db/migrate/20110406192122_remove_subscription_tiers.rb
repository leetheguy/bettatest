class RemoveSubscriptionTiers < ActiveRecord::Migration
  def self.up
    remove_column :subscriptions, :low_tier_price
    remove_column :subscriptions, :high_tier_price
    remove_column :subscriptions, :low_tier_year_price
    remove_column :subscriptions, :high_tier_year_price
    remove_column :subscriptions, :low_tier_months_left
    remove_column :subscriptions, :high_tier_months_left
    add_column :subscriptions, :price, :decimal, :default => 39.0
    add_column :subscriptions, :year_price, :decimal, :default => 399.0
    add_column :subscriptions, :months_left, :integer, :default => 0
 end

  def self.down
    remove_column :subscriptions, :tier_price
    remove_column :subscriptions, :tier_year_price
    remove_column :subscriptions, :months_left
    add_column :subscriptions, :low_tier_price,        :decimal, :default => 14.0
    add_column :subscriptions, :high_tier_price,       :decimal, :default => 6.0
    add_column :subscriptions, :low_tier_year_price,   :decimal, :default => 149.0
    add_column :subscriptions, :high_tier_year_price,  :decimal, :default => 299.0
    add_column :subscriptions, :low_tier_months_left,  :integer, :default => 0
    add_column :subscriptions, :high_tier_months_left, :integer, :default => 0
  end
end
