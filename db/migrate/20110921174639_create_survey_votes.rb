class CreateSurveyVotes < ActiveRecord::Migration
  def self.up
    create_table :survey_votes do |t|
      t.references :user
      t.references :survey
      t.boolean :voted

      t.timestamps
    end
  end

  def self.down
    drop_table :survey_votes
  end
end
