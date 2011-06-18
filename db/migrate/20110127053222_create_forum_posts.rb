class CreateForumPosts < ActiveRecord::Migration
  def self.up
    create_table :forum_posts do |t|
      t.text :post, :null => false

      t.references :forum_topic
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :forum_posts
  end
end
