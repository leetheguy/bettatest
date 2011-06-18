class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :null => false
      t.string :password, :null => false
      t.boolean :betta_email_opt_in, :null => false, :default => false
      t.boolean :agreed_tos, :null => false, :default => false
      t.date :last_login
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

