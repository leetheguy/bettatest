class CreatePolls < ActiveRecord::Migration
  def self.up
    drop_table :survey_options
    drop_table :survey_votes
    drop_table :surveys
    create_table :polls do |t|
      t.string  :name
      t.text    :description
      t.integer :beta_test_id
      t.text    :options
      t.integer :access_level
      t.timestamps
    end
    create_table :votes do |t|
      t.integer :user_id
      t.integer :poll_id
      t.integer :option
    end
  end

  def self.down
    drop_table :polls
    drop_table :votes
  end
end
