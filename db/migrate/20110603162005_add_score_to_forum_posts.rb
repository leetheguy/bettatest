class AddScoreToForumPosts < ActiveRecord::Migration
  def self.up
    add_column :forum_posts, :score, :integer, :default => 0
    add_column :referrals, :email, :string
  end

  def self.down
    remove_column :forum_posts, :score
    remove_column :referrals, :email
  end
end
