# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :auth_token do
    token "MyString"
    collector_id 1
    user_id 1
  end
end
