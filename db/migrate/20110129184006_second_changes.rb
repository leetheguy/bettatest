class SecondChanges < ActiveRecord::Migration
  def self.up
    add_column :beta_tests,  :active,    :boolean, :default => false
    add_column :users, :name, :string
    add_column :beta_tests, :link, :string
    add_column :beta_tests, :password, :string

    add_index :users, :email, :unique => true
    add_index :users, :name, :unique => true
    add_index :beta_tests, :name, :unique => true
                                                  
    change_column_default :beta_tests, :starting_points,			10
    change_column_default :beta_tests, :active_min_pts,				25
    change_column_default :beta_tests, :involved_min_pts, 		75
    change_column_default :beta_tests, :daily_drop_pts, 			1
    change_column_default :beta_tests, :daily_login_pts, 			1
    change_column_default :beta_tests, :forum_post_pts,				3
    change_column_default :beta_tests, :rate_up_lose_pts,			1
    change_column_default :beta_tests, :rate_up_give_pts,			2
    change_column_default :beta_tests, :rate_down_lose_pts,		2
    change_column_default :beta_tests, :rate_down_take_pts,		1
    change_column_default :beta_tests, :survey_vote_pts,			3
    
    create_table :beta_tests_tags do |t|
      t.references :beta_test
      t.references :tag
    end
    
    remove_column :ticket_categories, :user_id
    remove_column :tickets, :beta_test_id
    remove_column :tickets, :category_id
  end

  def self.down
  	remove_index :users, :email
  	remove_index :users, :name
  	remove_index :beta_tests, :name
  	
  	remove_column :users, :name
		remove_column :beta_tests, :link
    remove_column :beta_tests, :password
    remove_column :beta_tests,  :active

    change_column_default :beta_tests, :starting_points,				100
    change_column_default :beta_tests, :active_min_pts,				250
    change_column_default :beta_tests, :involved_min_pts, 			750
    change_column_default :beta_tests, :daily_drop_pts, 				10
    change_column_default :beta_tests, :daily_login_pts, 			10
    change_column_default :beta_tests, :forum_post_pts,				30
    change_column_default :beta_tests, :rate_up_lose_pts,			10
    change_column_default :beta_tests, :rate_up_give_pts,			20
    change_column_default :beta_tests, :rate_down_lose_pts,		20
    change_column_default :beta_tests, :rate_down_take_pts,		10
    change_column_default :beta_tests, :survey_vote_pts,				30
    
    drop_table :beta_tests_tags
    
    add_column :ticket_categories, :user_id, :int
    add_column :tickets, :beta_test_id, :int
    add_column :tickets, :category_id, :int
  end
end
