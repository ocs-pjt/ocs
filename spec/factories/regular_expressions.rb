# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :regular_expression do
    data "MyText"
    use_case_id 1
    already_handled false
    additional_information_id 1
  end
end
