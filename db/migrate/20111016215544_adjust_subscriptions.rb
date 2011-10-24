class AdjustSubscriptions < ActiveRecord::Migration
  def self.up
    change_table :subscriptions do |t|
      t.string :name, :stripe_customer_token
      t.remove :price, :year_price, :months_left
    end
  end

  def self.down
    change_table :subscriptions do |t|
      t.remove :name, :stripe_customer_token
      t.decimal :year_price, :price
      t.integer :months_left
    end
  end
end
