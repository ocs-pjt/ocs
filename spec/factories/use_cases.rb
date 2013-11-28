# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :use_case do
    key "abc"
    user
    collector_version
    program
    program_version

    factory :use_case_with_tags do 
      tags { [FactoryGirl.create(:tag), FactoryGirl.create(:tag)] }
    end
  end
end
