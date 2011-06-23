class AddAdminFlag < ActiveRecord::Migration
  def self.up
    add_column    :users, :is_admin, :boolean, :default => false
    add_column    :users, :inactive_until, :integer, :default => 0
    add_column    :users, :security_question, :string
    add_column    :users, :security_answer, :string
    remove_column :referrals, :referred_by
    add_column    :referrals, :referred_by, :integer
    rename_column :users, :agreed_tos, :agreed_to_tos
    add_index     :referrals, :referred_by, :unique
  end

  def self.down
    remove_column   :users, :is_admin
    remove_column   :users, :inactive_until
    remove_column   :users, :security_question
    remove_column   :users, :security_answer
    remove_column   :referrals, :referred_by
    add_column      :referrals, :referred_by, :string
    rename_column   :users, :agreed_to_tos, :agreed_tos
    remove_index    :referrals, :referred_by
  end
end
