class CreateSurveyOptions < ActiveRecord::Migration
  def self.up
    create_table :survey_options do |t|
      t.string :option, :null => false
      t.integer :votes, :default => 0
      
      t.references :survey
  
      t.timestamps
    end
  end

  def self.down
    drop_table :survey_options
  end
end
