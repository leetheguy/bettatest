class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string :title, :null => false
      t.text :post, :null => false
      t.boolean :draft, :default => true
      
      t.references :beta_test

      t.timestamps
    end
  end

  def self.down
    drop_table :blogs
  end
end
