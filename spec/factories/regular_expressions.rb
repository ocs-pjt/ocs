# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :regular_expression do
    data "MyRegExp"
    use_case
    additional_information
    already_handled false
  end
end
