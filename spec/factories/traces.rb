# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trace do
    data "MyText"
    use_case
    already_handled false
  end
end
