class SessionTable < ActiveRecord::Migration
  def self.up
    create_table :sessions do |t|
      t.references :user
      t.boolean :visitor,           :default => true
      t.boolean :unconfirmed_user,  :default => false
      t.boolean :plain_user,        :default => false
      t.boolean :tester,            :default => false 
      t.boolean :developer,         :default => false 
      t.boolean :admin,             :default => false 
    end
  end

  def self.down
    drop_table :sessions
  end
end
