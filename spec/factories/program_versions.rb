# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :program_version do
    sequence(:version) { |n| "1.0.#{n}" }
    program
  end
end
