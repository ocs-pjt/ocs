# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :in_progress_task do
    user_id 1
    job_id 1
  end
end
