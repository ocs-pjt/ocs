# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :permutation do
    data "1,2,3"
    use_case
    additional_information
  end
end
