# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :additional_information do
    operating_system "MyString"
    collection_point "MyString"
    optional "MyString"
    description "MyString"
    deferred_date "2014-02-27 15:28:10"
    postman_name "MyString"
    postman_version "MyString"
  end
end
