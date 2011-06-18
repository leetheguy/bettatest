class AuthenticationPreparationForUser < ActiveRecord::Migration
  def self.up
  	add_column :users, :password_hash, :string, :null => true
  	add_column :users, :password_salt, :string, :null => true
		add_column :users, :email_code, :string, :null => true
		
		remove_column :users, :password
  end

  def self.down
  	remove_column :users, :password_hash
  	remove_column :users, :password_salt
		remove_column :users, :email_code
		
		add_column :users, :password, :null => false
  end
end
