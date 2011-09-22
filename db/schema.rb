# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110921174639) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "beta_tests", :force => true do |t|
    t.string   "name",                                          :null => false
    t.integer  "max_testers",                :default => 100
    t.integer  "starting_points",            :default => 10
    t.integer  "active_min_pts",             :default => 25
    t.integer  "involved_min_pts",           :default => 75
    t.integer  "daily_drop_pts",             :default => 1
    t.integer  "daily_login_pts",            :default => 1
    t.integer  "forum_post_pts",             :default => 3
    t.integer  "rate_up_lose_pts",           :default => 1
    t.integer  "rate_up_give_pts",           :default => 2
    t.integer  "rate_down_lose_pts",         :default => 2
    t.integer  "rate_down_take_pts",         :default => 1
    t.integer  "survey_vote_pts",            :default => 3
    t.integer  "tester_days_to_gift",        :default => 0
    t.integer  "active_days_to_gift",        :default => 0
    t.integer  "involved_days_to_gift",      :default => 10
    t.boolean  "involved_can_merge_tickets", :default => true
    t.boolean  "involved_can_add_tickets",   :default => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.boolean  "open",                       :default => false
    t.boolean  "active",                     :default => false
    t.string   "link"
    t.string   "password"
  end

  add_index "beta_tests", ["name"], :name => "index_beta_tests_on_name", :unique => true

  create_table "beta_tests_tags", :id => false, :force => true do |t|
    t.integer "beta_test_id"
    t.integer "tag_id"
  end

  create_table "blogs", :force => true do |t|
    t.string   "name",                           :null => false
    t.text     "post",                           :null => false
    t.boolean  "draft",        :default => true
    t.integer  "beta_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_categories", :force => true do |t|
    t.string   "name",                        :null => false
    t.text     "description"
    t.integer  "beta_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "access_level", :default => 1
  end

  create_table "forum_posts", :force => true do |t|
    t.text     "post",                          :null => false
    t.integer  "forum_topic_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score",          :default => 0
  end

  create_table "forum_topics", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "forum_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "referrals", :force => true do |t|
    t.integer  "reward_at",      :default => 3
    t.integer  "rewards_given",  :default => 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "referred_by_id"
    t.string   "email"
  end

  add_index "referrals", ["referred_by_id"], :name => "index_referrals_on_referred_by_id"

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.integer "user_id"
    t.boolean "visitor",          :default => true
    t.boolean "unconfirmed_user", :default => false
    t.boolean "plain_user",       :default => false
    t.boolean "tester",           :default => false
    t.boolean "developer",        :default => false
    t.boolean "admin",            :default => false
    t.boolean "naughty",          :default => false
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",       :default => 39.0
    t.decimal  "year_price",  :default => 399.0
    t.integer  "months_left", :default => 0
  end

  create_table "survey_options", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "votes",      :default => 0
    t.integer  "survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "survey_id"
    t.boolean  "voted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.string   "name",                        :null => false
    t.text     "description"
    t.integer  "beta_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "access_level", :default => 1
  end

  create_table "tags", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tester_stat_sheets", :force => true do |t|
    t.integer  "level",         :default => 0
    t.integer  "points",        :default => 0
    t.integer  "days_at_level", :default => 0
    t.integer  "user_id"
    t.integer  "beta_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "level_frozen",  :default => false
    t.boolean  "points_frozen", :default => false
    t.integer  "position"
  end

  create_table "ticket_categories", :force => true do |t|
    t.string   "name",         :null => false
    t.text     "description"
    t.integer  "beta_test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", :force => true do |t|
    t.string   "name",                                   :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",             :default => "open"
    t.integer  "ticket_category_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :null => false
    t.boolean  "betta_email_opt_in", :default => false, :null => false
    t.boolean  "agreed_to_tos",      :default => false, :null => false
    t.date     "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "email_confirmed",    :default => false
    t.string   "name"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "email_code"
    t.integer  "inactive_until",     :default => 0
    t.string   "security_question"
    t.string   "security_answer"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true

end
