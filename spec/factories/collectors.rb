# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :collector do
    sequence(:name) { |n| "Ruby#{n}" }
  end
end
