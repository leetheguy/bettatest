class CreateTicketCategories < ActiveRecord::Migration
  def self.up
    create_table :ticket_categories do |t|
      t.string :name, :null => false
      t.text :description
      
      t.references :user
      t.references :beta_test

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_categories
  end
end
