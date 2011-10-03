ActiveAdmin.register ForumCategory do
  menu :parent => "Beta Tests"

  filter :name
  filter :beta_test
  filter :access_level, :as => :select, :collection => {  "activated" => 1, "active" => 2, "involved" => 3 }
  filter :created_at
  filter :updated_at

  index do
    column :name, :sortable => :name do |fc|
      link_to fc.name, admin_forum_category_path(fc)
    end
    column :beta_test do |fc|
      link_to fc.beta_test.name, admin_beta_test_path(fc.beta_test)
    end
    column :description do |fc|
      fc.description[0..20]+"..."
    end
    column :access_level do |fc|
      l = fc.access_level
      level_name = l==1?"activated":level_name
      level_name = l==2?"active":level_name
      level_name = l==3?"involved":level_name
    end
    column :created_at
    column :updated_at
  end
end
