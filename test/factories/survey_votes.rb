# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :survey_vote do
      user nil
      survey nil
      voted false
    end
end