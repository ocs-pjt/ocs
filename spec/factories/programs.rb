# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :program do
    sequence(:name) { |n| "MyString#{n}" }
    description "MyText"
  end
end
