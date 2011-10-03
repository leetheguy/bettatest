ActiveAdmin.register BetaTest do
  filter :name
  filter :user, :label => "developer"
  filter :open, :as => :select, :collection => ["true", "false"]
  filter :active, :as => :select, :collection => ["true", "false"]
  filter :active
  filter :created_at
  filter :updated_at

  index do
    column :name, :sortable => :name do |bt|
      link_to bt.name, admin_beta_test_path(bt)
    end
    column :developer do |bt|
      link_to bt.user.name, admin_user_path(bt.user)
    end
    column :description do |bt|
      bt.description[0..20]+"..."
    end
    column :link do |bt|
      s = bt.link.gsub(/http:\/\//, "")
      s = "http://"+s
      link_to s, s
    end
    column :password, :sortable => false
    column :open, :sortable => false
    column :active, :sortable => false
    column :created_at
    column :updated_at
  end
end
