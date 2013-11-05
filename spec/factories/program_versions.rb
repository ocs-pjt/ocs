# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :program_version do
    version "MyString"
    program_id 1
  end
end
