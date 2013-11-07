# TODO : eventually delete and reset need to be removed
[User, Tag, Collector, CollectorVersion, UseCase, TagsUseCase].each do |klass|
  klass.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!(klass.table_name)
end

user = User.new(email: 'test@test.com',
                password: 'test1234',
                password_confirmation: 'test1234')
user.confirm!
user.authentication_token = "YWyHE936yyeMAV9jvKDE"
user.save!

user2 = User.new(email: 'vialette@univ-mlv.fr',
                password: 'test1234',
                password_confirmation: 'test1234')
user2.confirm!
user2.authentication_token = "GNp72m1Tmu9Hym4a7h6n"
user2.save!

Tag.create!([{name: 'Genomic'}, {name: 'Mathematic'}])

tag1 = Tag.first
tag2 = Tag.last

file = Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'fixtures', 'files', 'fake.txt')))
Collector.create!([{name: 'RUBY', file: file },{name: 'PYTHON', file: file }])

collector1 = Collector.first
collector2 = Collector.last

CollectorVersion.create!([
  {version: '1.0.0', collector_id: collector1.id}, 
  {version: '1.0.1', collector_id: collector1.id},
  {version: '2.0.0', collector_id: collector2.id},
  {version: '2.0.1', collector_id: collector2.id}
])

collector_version1 = CollectorVersion.first
collector_version2 = CollectorVersion.last

UseCase.create!([
  {key: "abc", user_id: user.id, collector_id: collector1.id, collector_version_id: collector_version1.id},
  {key: "def", user_id: user.id, collector_id: collector2.id, collector_version_id: collector_version2.id}
])

use_case1 = UseCase.first
use_case2 = UseCase.last

TagsUseCase.create!([
  {tag_id: tag1.id, use_case_id: use_case1.id},
  {tag_id: tag2.id, use_case_id: use_case1.id},
  {tag_id: tag2.id, use_case_id: use_case2.id}
])
# Set sequence id to specific value example
# ActiveRecord::Base.connection.execute("SELECT setval('parties_party_id_seq', 9, false);")