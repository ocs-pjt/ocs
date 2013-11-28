# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :collector_version do
    sequence(:version) { |n| "1.0.#{n}" }
    collector
    file Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'fixtures','files', 'fake.txt')))
  end
end
