# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :collector_version do
    version "MyString"
    collector_id 1
  end
end
