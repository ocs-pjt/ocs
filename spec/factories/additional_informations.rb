# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :additional_information do
    operating_system "Windows"
    collection_point "Sort"
    optional "Info"
    description "Desc info"
    deferred_date "2014-02-27 15:28:10"
    postman_name "Dude"
    postman_version "1.0.0"
  end
end
