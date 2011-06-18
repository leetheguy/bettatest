class FixBetaTestsTags < ActiveRecord::Migration
  def self.up
  	drop_table :beta_tests_tags
    create_table :beta_tests_tags, :id => false do |t|
      t.references :beta_test
      t.references :tag
    end
  end

  def self.down
  	drop_table :beta_tests_tags
    create_table :beta_tests_tags do |t|
      t.references :beta_test
      t.references :tag
    end
  end
end
