class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.string :name, :null => false
      t.text :description

      t.references :beta_test

      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
