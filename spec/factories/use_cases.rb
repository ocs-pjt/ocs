# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :use_case do
    key "MyString"
    user_id 1
    collector_id 1
    collector_version_id 1
    program_id 1
    program_version_id 1
  end
end
