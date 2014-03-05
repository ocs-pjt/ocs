# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    user
    file Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'fixtures','files', 'fake.txt')))
  end
end
