class RemoveSubscriptionTierField < ActiveRecord::Migration
  def self.up
    remove_column :subscriptions, :current_tier
  end

  def self.down
    add_column :subscriptions, :current_tier, :integer, :default => 0
  end
end
