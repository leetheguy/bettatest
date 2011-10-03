ActiveAdmin.register User do
  filter :name
  filter :email
  filter :betta_email_opt_in, :label => "opted in", :as => :select, :collection => ['true', 'false']
  filter :agreed_to_tos, :as => :select, :collection => ['true', 'false']
  filter :email_confirmed, :label => "email confirmed", :as => :select, :collection => ['true', 'false']
  filter :inactive_until, :as => :numeric
  filter :security_question
  filter :security_answer
  filter :last_login
  filter :created_at
  filter :updated_at

  index do
    column :name, :sortable => :name do |user|
      link_to user.name, admin_user_path(user)
    end
    column :email
    column 'opted in', :sortable => false do |user|
      user.betta_email_opt_in
    end
    column :agreed_to_tos, :sortable => false
    column :email_confirmed, :sortable => false do |user|
      if !user.email_confirmed
        link_to 'false', confirm_user_path(user, :email_code => user.email_code)
      else
        'true'
      end
    end
    column :inactive_until do |user|
      inactive = user.inactive_until>0?true:false
      if inactive
        user.inactive_until.days.from_now.strftime("%D")
      else
        "active"
      end
    end
    column :last_login
    column :created_at
    column :updated_at
  end
end
