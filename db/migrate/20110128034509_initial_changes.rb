class InitialChanges < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name, :null => false
      t.timestamps
    end
    
    create_table :beta_tests_users, :id => false do |t|
      t.references :beta_test
      t.references :user
    end
		
		add_column :tester_stats,      :level_frozen,    :boolean, :default => false
		add_column :tester_stats,      :points_frozen,   :boolean, :default => false
		add_column :forum_categories,  :access_level,    :integer, :default => 1
		add_column :users,             :email_confirmed, :boolean, :default => false
		add_column :tester_stats,      :position,        :integer, :not_null => true
    add_column :beta_tests,        :description,     :text
    add_column :beta_tests,        :open,            :boolean, :default => false
    add_column :surveys,           :access_level,    :integer, :default => 1
    add_column :tickets,           :status,          :string,  :default => "open"
    
    rename_column :forum_topics,    :title,     :name
    rename_column :beta_tests,      :test_name, :name
    rename_column :survey_options,  :option,    :name
    rename_column :blogs,           :title,     :name
		
		remove_column :tester_stats, :user
    
    add_column    :tickets, :ticket_category_id, :integer
  end

  def self.down
		drop_table :tags
		drop_table :beta_tests_users
    
    remove_column :tester_stats,     :level_frozen
    remove_column :tester_stats,     :points_frozen
    remove_column :forum_categories, :access_level
    remove_column :users,            :email_confirmed
    remove_column :tester_stats,     :position
    remove_column :beta_tests,        :description
    remove_column :beta_tests,        :open
    remove_column :surveys,           :access_level
    remove_column :tickets,           :status
    
    rename_column :forum_topics,   :name, :title
    rename_column :beta_tests,     :name, :test_name
    rename_column :survey_options, :name, :option
    rename_column :blogs,          :name, :title

    add_column :tester_stats, user

    remove_column :tickets, :ticket_category_id
  end
end
