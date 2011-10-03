 ActiveAdmin.register Blog do
  menu :parent => "Beta Tests"

  filter :name
  filter :beta_test
  filter :draft, :as => :select, :collection => ["true", "false"]
  filter :created_at
  filter :updated_at

  index do
    column :name, :sortable => :name do |blog|
      link_to blog.name, admin_blog_path(blog)
    end
    column :beta_test do |blog|
      link_to blog.beta_test.name, admin_beta_test_path(blog.beta_test)
    end
    column :post, :sortable => false do |blog|
      blog.post[0..100]+"..."
    end
    column "unpublished", :sortable => false do |blog|
      blog.draft.to_s
    end
    column :created_at
    column :updated_at
  end
end
