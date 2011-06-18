class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :name, :null => false
      t.text :description

      t.references :category
      t.references :beta_test

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
