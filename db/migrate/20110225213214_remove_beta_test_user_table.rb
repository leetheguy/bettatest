class RemoveBetaTestUserTable < ActiveRecord::Migration
  def self.up
  	drop_table :beta_tests_users
  end

  def self.down
    create_table :beta_tests_users, :id => false do |t|
      t.references :beta_test
      t.references :user
    end
  end
end
