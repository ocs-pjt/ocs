# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trace do
    data "MyText"
    use_case_id 1
    already_handled false
  end
end
