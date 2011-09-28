require "core_ext/integer"

FactoryGirl.define do
  sequence :email do |n|
    Faker::Internet.email(Faker::Internet.user_name + n.to_s)
  end

  factory :beta_test do |f|
    f.sequence(:name) { |n| "#{Faker::Internet.domain_name} No. #{n}" }
    f.description Faker::Company.bs + ", " + Faker::Company.bs + "and " + Faker::Company.bs
    f.active      { [true, false][rand 2] }
    f.open        false
    f.link        true
    f.password    8.random_characters
    f.association :user, :factory => :user
  end

  factory :open_active_beta_test, :parent => :beta_test do
    open   true
    active true
  end

  factory :open_inactive_beta_test, :parent => :beta_test do
    open   true
    active false
  end

  factory :closed_active_beta_test, :parent => :beta_test do
    open   false
    active true
  end

  factory :closed_inactive_beta_test, :parent => :beta_test do
    open   false
    active false
  end

  factory :blog do
    name Faker::Company.catch_phrase
    post Faker::Lorem.paragraphs 6
    draft { [true, false][rand 2] }
    beta_test
  end

  factory :forum_category do
    name Faker::Company.bs
    description Faker::Lorem.sentence 8
    access_level { rand(3)+1 }
    beta_test
  end

  factory :standard_forum_category, :parent => :forum_category do
    access_level 1
  end

  factory :active_forum_category, :parent => :forum_category do
    access_level 2
  end

  factory :involved_forum_category, :parent => :forum_category do
    access_level 3
  end

  factory :forum_topic do
    name Faker::Company.bs
    description Faker::Lorem.sentence 8
    user
    association :forum_category, :factory => :standard_forum_category
  end

  factory :forum_post do
    post Faker::Lorem.paragraphs 6
    forum_topic
    user
  end

  factory :referral do
    user
    association :referred_by, :factory => :user
  end

  factory :subscription do
    association :user, :factory => :user
    months_left { rand(12)+1 }
  end

  factory :survey do
    name Faker::Company.bs
    description Faker::Lorem.sentence 8
    access_level { rand(3)+1 }
    beta_test
  end

  factory :standard_survey, :parent => :survey do
    name Faker::Company.bs
    description Faker::Lorem.sentence 8
    beta_test
    access_level 1
  end

  factory :active_survey, :parent => :survey do
    name Faker::Company.bs
    description Faker::Lorem.sentence 8
    beta_test
    access_level 2
  end

  factory :involved_survey, :parent => :survey do
    name Faker::Company.bs
    description Faker::Lorem.sentence 8
    beta_test
    access_level 3
  end

  factory :survey_option do
    name Faker::Company.bs
    votes { rand(11) }
    survey
  end

  factory :tag do
    name 7.random_characters
  end

  factory :tester_stat_sheet do
    level { rand(5)-1 }
    points { [0, rand(25), 25+rand(50), 75+rand(50), -1][level] }
    days_at_level { rand 30 }
    association :user, :factory => :user
    beta_test
  end

  factory :ticket_category do
    name Faker::Company.bs
    description Faker::Lorem.sentence 8
    beta_test
  end

  factory :ticket do
    name Faker::Company.bs
    description Faker::Lorem.paragraphs 3
    ticket_category
  end

  factory :user do
    email
    betta_email_opt_in { [true, false][rand 2] }
    agreed_to_tos "1"
    last_login { Date.today - rand(14) }
    email_confirmed true
    sequence (:name) { |n| "#{Faker::Internet.user_name}#{n}" }
    password "password"
    email_code 20.random_characters
    security_question Faker::Company.bs
    security_answer Faker::Name.name
  end

  factory :unconfirmed_user, :parent => :user do
    email_confirmed false
  end

  factory :naughty_user, :parent => :user do
    inactive_until { rand(15)+7 }
  end
end
